//
//  ChatFlow.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 21/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//


import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift
class ChatFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    private let services: AppServices
    
    init(services: AppServices) {
        self.services = services
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .chats :
            return navigateChats()
        case .dismiss:
            return navigateDismiss()
        case .Complete:
            return navigateFinish()
        case .chat(let sendUserId , let sendUserName) :
            return navigateChat(sendUserId: sendUserId , sendUserName: sendUserName)
        default:
            return .none
            
        }
    }
    
    private func navigateChats() -> FlowContributors {
        let viewController = RecentChatController.instantiate(withViewModel: RecentChatViewModel(),
                                                                andServices: self.services)
               
       self.rootViewController.pushViewController(viewController, animated: true)
       let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
       return .one(flowContributor: nexFlowItem)
    }
    
    
    private func navigateChat(sendUserId : Int64 , sendUserName : String) -> FlowContributors {
        let viewModel = ChatViewModel()
        viewModel.sendUserId = sendUserId
        viewModel.sendUserName = sendUserName
        let viewController = ChatController.instantiate(withViewModel:viewModel ,
                                                                andServices: self.services)
               
       self.rootViewController.pushViewController(viewController, animated: true)
       let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
       return .one(flowContributor: nexFlowItem)
    }
    
    private func navigateDismiss() -> FlowContributors {
        
        self.rootViewController.popViewController(animated: true)
        
        return .none
    }
    
    
    private func navigateFinish() -> FlowContributors {
        
        self.rootViewController.dismiss(animated: true)
        
        return .none
    }
}

class ChatStepper: Stepper {
       
       let steps = PublishRelay<Step>()
       private let disposeBag = DisposeBag()
       
       var initialStep: Step {
           return AppStep.chats
       }
   }
