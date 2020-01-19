//
//  PostViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 13/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Gallery

class PostViewModel: Stepper , ServicesViewModel {
    let steps = PublishRelay<Step>()
    let disposeBag = DisposeBag()
    
    var tags : String = ""
    var links : String = ""
    
    let _message = BehaviorRelay<String>(value: "")
    let _title = BehaviorRelay<String>(value: "")
    
    let response = PublishSubject<Bool>()
    
    let data : UIImage? = nil
    
    var message = ""
    var title = ""
    
    
    var image : [Image] = []
    
    init() {
        _message.subscribe(onNext: { (newValue) in
            self.message = newValue
        }).disposed(by: disposeBag)
        
        _title.subscribe(onNext: { (newValue) in
            self.title = newValue
        }).disposed(by: disposeBag)
    }
    
    typealias Services = HasApiService
    
    var services: Services!
    public func doFinish() {
        self.steps.accept(AppStep.dismiss)
    }
    
    public func doSave(_ image : UIImage?) {
        
        guard let image = image else {
            return
        }
        
        let parameter : [String : String] = [
            CodeUtils.parameter.STORY_DATE : String(CommonUtils.getCurrentTimeStampe()),
            CodeUtils.parameter.STORY_TITLE : self.title,
            CodeUtils.parameter.STORY_TAG : self.tags,
            CodeUtils.parameter.STORY_MESSAGE : self.message
        ]
        
        
        services.apiService.upload(image: image, type: PostModel.self,   path: RequestUrl.story, parameters: parameter, completion: self.completionHandler).disposed(by: disposeBag)
    }
    
    func completionHandler(_ value : PostModel? , state : Bool) -> Void {
        guard value != nil else {
            response.onNext(false)
            return
        }
        
        if state {
           response.onNext(true)
        } else {
           response.onNext(false)
        }
    }
}
