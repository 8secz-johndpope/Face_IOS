//
//  PasswordChangeViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 11/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class PasswordChangeViewModel: Stepper , ServicesViewModel {
    let steps = PublishRelay<Step>()
    typealias Services = HasApiService
    
    var services: Services!
    
    
    func doFinish(){
        self.steps.accept(AppStep.dismiss)
    }
    
    func doMain(){
        self.steps.accept(AppStep.mainPage)
    }
    
}
