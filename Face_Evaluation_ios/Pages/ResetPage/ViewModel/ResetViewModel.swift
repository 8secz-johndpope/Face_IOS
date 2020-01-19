//
//  ResetViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 10/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Gallery
class ResetViewModel : Stepper , ServicesViewModel{
    let steps = PublishRelay<Step>()
    let disposeBag = DisposeBag()
    typealias Services = HasApiService
    
    var services: Services!
    public func doFinish() {
        self.steps.accept(AppStep.dismiss)
    }
    
    public func doPasswordChangePage(){
        self.steps.accept(AppStep.PasswordChangePage)
    }
}
