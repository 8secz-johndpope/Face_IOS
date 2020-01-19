//
//  ApiService.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxAlamofire


protocol HasApiService {
   var apiService: ApiService { get }
   var preferencesService: PreferencesService { get }
}


class ApiService {
   
    func upload<T : Codable>(image data : UIImage , type : T.Type , path : String , parameters : [String : String] , completion : @escaping (_ getValue : T? , _ state : Bool ) -> Void) -> Disposable {
        
        let api = network(method : .post , path : path , parameters: parameters )
        
        return api.requestUploadApi(data).debug().retry(2).map({ (data) -> T in
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                
                return model
            }catch {
                throw ErrorCode.RESPONSE_PARSE_ERROR
            }
        }).subscribe(onNext: { value in
            completion(value,true)
        }, onError: { (error) in
            completion(nil,false)
        })
    }
    
    func request<T : Codable>(type : T.Type,method : RequestType , path : String , parameters : [String : String] , completion : @escaping (_ getValue : T?) -> Void) -> Disposable {
        let api = network(method : method , path : path , parameters: parameters )
        
        return api.requestApi().debug().retry(2).mapObject(type: T.self).subscribe(onNext: { value in
            completion(value)
        }, onError: { (error) in
            completion(nil)
        })
    }
}

extension ObservableType {
    
    public func mapObject<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            let responseTuple = data as? (HTTPURLResponse, Data)
            
            guard let jsonData = responseTuple?.1 else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
                )
            }
        
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: jsonData)
            
            return Observable.just(object)
        }
    }
    
    public func mapArray<T: Codable>(type: T.Type) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            let responseTuple = data as? (HTTPURLResponse, Data)
            
            guard let jsonData = responseTuple?.1 else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
                )
            }
            
            let decoder = JSONDecoder()
            let objects = try decoder.decode([T].self, from: jsonData)
            
            return Observable.just(objects)
        }
    }
}



