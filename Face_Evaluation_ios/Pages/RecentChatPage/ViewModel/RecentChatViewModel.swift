//
//  RecentChatViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 21/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

import RxFlow
import RxSwift
import RxCocoa
class RecentChatViewModel :Stepper , ServicesViewModel {
    
       let steps = PublishRelay<Step>()
       let disposeBag = DisposeBag()
       typealias Services = HasApiService
       
       var services: Services!

       
       func doFinish() {
            self.steps.accept(AppStep.Complete)
       }
    
    func nextStep(_ sendUserId : Int64 , _ sendUserName : String) {
        self.steps.accept(AppStep.chat(sendUserId: sendUserId , sendUserName:  sendUserName))
    }
    
    func initData() {
        if let userId : Int64 = services.preferencesService.getValue(UserPreferences.userId , 0) {
            ChatClient.shard.recentList(userId)
        }
    }
}
