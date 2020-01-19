//
//  GrpcClient.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 20/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftGRPC
import SwiftEventBus
class ChatClient {
    
    static let shard = ChatClient()
    
    var sendCall : Com_Gunwook_Face_ChatServicesendCall? = nil
    let client = Com_Gunwook_Face_ChatServiceServiceClient.init(address: RequestUrl.GRPC_BASE_URL , secure: false)
    func connect() {
        self.sendCall = try? client.send(completion: { (list) in
            SwiftEventBus.post(CodeUtils.EventBus.SEND_MESSAGE , sender: list.resultData)
        })
    }
    
    func disconnect() {
        do{
            try self.sendCall?.closeSend(completion: {
                SwiftEventBus.post(CodeUtils.EventBus.SEND_MESSAGE_DISCONNECT , sender: "")
            })
        }catch {
            print("disconnect Failed")
        }
    }
    
    func recentList(_ userId : Int64) -> Promise<Data?> {
        
        var auth = Com_Gunwook_Face_Auth()
        
        auth.userID = userId
        
        return Promise<Data?>() { seal in
            do {
                _ = try client.recentList(auth, completion: { (result) in
                    seal.fulfill(result.resultData)
                })
            }catch {
                seal.reject(error)
            }
        }
        
    }
    
    func chatList(_ userId : Int64 , _ sendUserId : Int64 , _ offset : Int32) -> Promise<[ChatModel]>{
        return Promise<[ChatModel]>() { seal in
            var user = Com_Gunwook_Face_User()
            
            var list : [ChatModel] = []
            user.userID = userId
            user.sendUserID = sendUserId
            user.limit = 30
            user.offset = offset
            
            do {
                let chatCall = try client.chatList(user, completion: { (result) in
                    
                    if result.success {
                        seal.fulfill(list)
                    }else {
                        seal.reject(GRPCError.RESPONSE_ERROR)
                    }
                    print("finish")
                })
                
                
                var running = true
                while running {
                  do {
                    let responseMessage = try chatCall.receive()
                    
                    guard let message = responseMessage else {
                        throw GRPCError.RESPONSE_END
                    }
                    
                    list.append(ChatModel(chatId: message.chatID, userName: message.userName, userId: message.userID, createAt: message.createAt, sendUserId: message.sendUserID, profileImg: message.profileImg, deleteAt: message.deleteAt, message: message.message))
                    
                  } catch{
                    running = false
                  }
                }
            }catch {
                  seal.reject(GRPCError.CLIENT_ERROR)
            }
        }
    }
    
    func sendMessage(_ userName : String ,_ userID : Int64 , _ createAt : Int64 ,_ sendUserID : Int64 , _  profileImg : String, _ deleteAt : Int64 , _ message : String){
        
        do {
            var model = Com_Gunwook_Face_ChatModel()
            
            model.chatID = 0
            model.userName = userName
            model.userID = userID
            model.createAt = createAt
            model.sendUserID = sendUserID
            model.profileImg = profileImg
            model.deleteAt = deleteAt
            model.message = message
                    
            
            try sendCall?.send(model) { (error) in
                SwiftEventBus.post(CodeUtils.EventBus.SEND_MESSAGE_ERROR , sender: error)
            }
        }catch {
            SwiftEventBus.post(CodeUtils.EventBus.SEND_MESSAGE_ERROR , sender: error)
        }
    }
}


enum GRPCError : Error {
    case RESPONSE_END
    case RESPONSE_ERROR
    case CLIENT_ERROR
}
