//
//  LoginViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 09/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class LoginViewModel: Stepper , ServicesViewModel {
    let steps = PublishRelay<Step>()
    let disposeBag = DisposeBag()
    typealias Services = HasApiService
    
    var services: Services!
    var loginModel = PublishSubject<LoginModel?>()

    
    public func doSave(_ model : LoginModel) {
       services.preferencesService.setValue(UserPreferences.email, model.email)
       services.preferencesService.setValue(UserPreferences.token, model.token)
       services.preferencesService.setValue(UserPreferences.userId, model.userId)
       self.steps.accept(AppStep.Complete)
    }
    
    public func doFinish() {
        self.steps.accept(AppStep.Complete)
    }
    
    public func doResetPage(){
        self.steps.accept(AppStep.ResetPage)
    }
    
    public func doSignUpPage(){
        self.steps.accept(AppStep.SignUpPage)
    }
    
    public func dologin(email : String , password : String ){
        let data : [String : String] = [ CodeUtils.parameter.EMAIL: email , CodeUtils.parameter.PASSWORD: password]
        self.services.apiService.request(type: LoginModel.self, method: .post, path: RequestUrl.login, parameters: data, completion: completionHandler).disposed(by: disposeBag)
    }
    
    
    
    func completionHandler(_ value : LoginModel?) -> Void {
        guard let model = value else {
            loginModel.onNext(nil)
            return
        }
        
        if let status = model.status {
            if status == 200 {
                loginModel.onNext(value)
            }else {
                loginModel.onNext(nil)
            }
        }else {
            loginModel.onNext(nil)
        }
    }
}
