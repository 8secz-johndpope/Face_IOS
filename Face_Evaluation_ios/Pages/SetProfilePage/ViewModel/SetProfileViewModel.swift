//
//  SetProfileViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 13/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import Gallery
import RxCocoa


class SetProfileViewModel : Stepper , ServicesViewModel {
    
    
    let _fullName = BehaviorRelay<String>(value: "")
    let _nickName = BehaviorRelay<String>(value: "")
    let _gender = BehaviorRelay<String>(value: "")
    let _aboutMe = BehaviorRelay<String>(value: "")
    
    let toast = PublishSubject<String>()
    
    let response = PublishSubject<Bool>()

    
    var fullName = ""
    var gender = ""
    var aboutMe = ""
    var nickName = ""
    var email = ""
    var password = ""
    
    let disposeBag = DisposeBag()
   
    init() {
        _fullName.subscribe(onNext: { (newValue) in
            self.fullName = newValue
        }).disposed(by: disposeBag)
        
        _nickName.subscribe(onNext: { (newValue) in
            self.nickName = newValue
        }).disposed(by: disposeBag)
        
        _gender.subscribe(onNext: { (newValue) in
                 self.gender = newValue
             }).disposed(by: disposeBag)
        
        _aboutMe.subscribe(onNext: { (newValue) in
                 self.aboutMe = newValue
             }).disposed(by: disposeBag)
    }
       
    
    let steps = PublishRelay<Step>()
    typealias Services = HasApiService
    
    var services: Services!
    
    var representImg : UIImage? = nil
    
    func doFinish(){
        self.steps.accept(AppStep.dismiss)
    }
    
    func doComplete() {
        self.steps.accept(AppStep.Complete)
    }
    
    
    func doSave(){
        guard let image = representImg else {
            toast.onNext(CodeUtils.string.PROFILEIMAGESET)
            return
        }
        
        guard !email.isEmpty else {
            toast.onNext(CodeUtils.string.EMAILCHECK)
            return
        }
        
        guard !password.isEmpty else {
                   toast.onNext(CodeUtils.string.PASSWORDCHECK)
                   return
        }
        
        guard !fullName.isEmpty else {
           toast.onNext(CodeUtils.string.NAMECHECK)
           return
        }
        
        guard !nickName.isEmpty else {
           toast.onNext(CodeUtils.string.NICKNAMECHECK)
           return
        }
        
        guard !gender.isEmpty else {
           toast.onNext(CodeUtils.string.GENDERCHECK)
           return
        }
        
        guard !aboutMe.isEmpty else {
           toast.onNext(CodeUtils.string.INTRODUCECHECK)
           return
        }
        
        let parameter : [String : String] = [
                  CodeUtils.parameter.NAME : fullName,
                  CodeUtils.parameter.NICKNAME : nickName,
                  CodeUtils.parameter.EMAIL : email,
                  CodeUtils.parameter.GENDER : gender,
                  CodeUtils.parameter.MESSAGE : aboutMe,
                  CodeUtils.parameter.CREATEAT : String(CommonUtils.getCurrentTimeStampe()),
                  CodeUtils.parameter.ROLE : CodeUtils.common.ROLE_USER,
                  CodeUtils.parameter.PASSWORD : password
        ]
        
        services.apiService.upload(image: image, type: SignUpModel.self, path: RequestUrl.signup, parameters: parameter, completion: self.completionHandler).disposed(by: disposeBag)
    }

    func completionHandler(_ value : SignUpModel? , state : Bool) -> Void {
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
