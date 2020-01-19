//
//  ChatViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 26/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

import RxFlow
import RxSwift
import RxCocoa
import PromiseKit
import AwaitKit
class ChatViewModel :Stepper , ServicesViewModel {
    
       let steps = PublishRelay<Step>()
       let disposeBag = DisposeBag()
       var sendUserId : Int64 = 1
       var sendUserName = ""
    
       var offset : Int32 = 0
       typealias Services = HasApiService
       
       var services: Services!

       let _message = BehaviorRelay<String>(value: "")
       let reloadData : PublishSubject<Bool> = PublishSubject()
       var listOfItems : [ChatModel] = []
       private var message = ""
        
      init() {
            _message.subscribe(onNext: { (newValue) in
                self.message = newValue
            }).disposed(by: disposeBag)
        }
    
        func executeGetChatList() {
            async {
                do {
                    if let userId  :Int64 = self.services.preferencesService.getValue(UserPreferences.userId , 1) {
                        //let list = try await()
                        self.listOfItems = try await(ChatClient.shard.chatList(userId, self.sendUserId,self.offset))
                        
                        self.reloadData.onNext(true)
                    } else {
                        self.reloadData.onNext(false)
                    }
                }catch {
                     self.reloadData.onNext(false)
                }
            }
       }
    
        func executeConnect() {
            ChatClient.shard.connect()
        }
    
        func executeDisConnect() {
            ChatClient.shard.disconnect()
        }
    
        func executeSendMessage() {
            ChatClient.shard.sendMessage("leegunwook", 1 , CommonUtils.getCurrentTimeStampe(), sendUserId, "TESTTEST", 0 , "message")
        }
       
       func doFinish() {
            self.steps.accept(AppStep.dismiss)
       }
    
}
