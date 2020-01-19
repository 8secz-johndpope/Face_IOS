//
//  ApiRequest.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

struct network: ApiRequest {
    var method: RequestType = RequestType.post
    var path: String = ""
    var parameters: [String : String] = [:]
}

protocol ApiRequest{
    var method : RequestType { get }
    var path : String { get }
    var parameters : [String : String ]{ get}
}
extension ApiRequest {
    
    func requestApi(_ baseUrl : String = RequestUrl.API_BASE_URL) -> Observable<(HTTPURLResponse, Data)> {
        
        var type: Alamofire.HTTPMethod
        
        switch method {
            case RequestType.post:
                type = .post
            default:
                type = .get
        }
        
        return RxAlamofire.requestData(type,
                                       baseUrl + path,
                                       parameters: parameters,
                                       encoding: JSONEncoding.default,
                                       headers: nil)
        
    }
    
    func requestUploadApi(_ image : UIImage ,  _ baseUrl : String = RequestUrl.API_BASE_URL) -> Observable<Data> {
        return Observable.create { observer in

            let URL = try! URLRequest(url: baseUrl + self.path, method: .post)

            Alamofire.upload(
                multipartFormData: { formData in
                    guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
                    
                    let number = Int.random(in: 0 ... 100)

                    formData.append(imageData, withName: "files" ,  fileName: String(number) + ".jpg", mimeType: "image/jpg")
                    for (key, value) in self.parameters {
                        formData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                },
                with: URL,
                encodingCompletion: { encodingResult in

                    do {
                        switch encodingResult {

                        case .success(let upload, _, _):
                            upload.responseJSON { response in
                                
                            guard let data = response.data else {
                                observer.onError(ErrorCode.RESPONSE_DATA_NULL_ERROR)
                                return
                            }
                                
                            if let result = response.result.value  {
                                
                                let status : Int = (result as? NSDictionary)?.object(forKey: "status") as? Int ?? 401
                                
                                if status != 200 {
                                    observer.onError(ErrorCode.RESPONSE_HTTP_STATUS_CODE_ERROR)
                                    return
                                }
                            }
                                
                            if let error = response.result.error {
                                observer.onError(error)
                            }else {
                                observer.onNext(data)
                                observer.onCompleted()
                            }
                                
                           
                        }
                        case .failure(let encodingError):
                            observer.onError(encodingError)
                        }
                    }catch {
                        observer.onError(error)
                    }
                }
            )

            return Disposables.create()
        }
    }
}
