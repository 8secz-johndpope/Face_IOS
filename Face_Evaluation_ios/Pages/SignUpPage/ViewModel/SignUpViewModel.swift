//
//  SignUpViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 12/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class SignUpViewModel : Stepper , ServicesViewModel {
    let steps = PublishRelay<Step>()
    typealias Services = HasApiService
    
    var services: Services!
    
    
    func doFinish(){
        self.steps.accept(AppStep.dismiss)
    }
    
    func doSetProfilePage(_ email : String , _ password : String){
        self.steps.accept(AppStep.SetUpProfile(email: email, password: password))
    }
}
