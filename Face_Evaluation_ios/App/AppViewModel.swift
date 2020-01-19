//
//  AppViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Gallery
class AppViewModel: Stepper , ServicesViewModel {
    let steps = PublishRelay<Step>()
    
    typealias Services = HasApiService
    
    var services: Services!
    
    init() {
        
    }
    
    public func doFinish() {
        self.steps.accept(AppStep.dismiss)
    }
    
    public func toPostController(_ image : [Image]) {
        self.steps.accept(AppStep.post(image: image))
    }
    
    public func movePostDetailController() {
        self.steps.accept(AppStep.postDetail)
    }
    
    public func toLogin() {
        self.steps.accept(AppStep.user)
    }
    
    public func toChats(){
        self.steps.accept(AppStep.chats)
    }
}
