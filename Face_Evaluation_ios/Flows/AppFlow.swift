//
//  AppFlow.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//


import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift
import KYDrawerController
import Gallery
class AppFlow: Flow {
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
            case .mainPage:
                return navigateMain()
            case .user:
                return navigateUser()
            case .post(let image) :
                return navigatePost(with: image)
            case .postDetail:
                return navigatePostDetail()
            case .dismiss :
                return navigateBack()
            case .chats :
                return navigateChat()
            default :
                return .none
            
        }
    }
    
    private func navigateBack() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        return .none
    }
    
    
    private func navigateMain() -> FlowContributors {
        
        let viewController = ViewController.instantiate(withViewModel: AppViewModel(),
                                                 andServices: self.services)
        
        let controller = DrawerViewController()
        
        controller.viewModel = viewController.viewModel
        
        let drawerController = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        
        viewController.drawerController = drawerController
        
        drawerController.mainViewController = UINavigationController(
                   rootViewController: viewController
               )
        drawerController.drawerViewController = controller
               
        
        
        self.rootViewController.pushViewController(drawerController, animated: true)
        
        let nexFlowItem = FlowContributor.contribute(withNextPresentable: drawerController, withNextStepper: viewController.viewModel)
        return .one(flowContributor: nexFlowItem)
    }
    
    private func navigateUser() -> FlowContributors {
        let userFlow = UserFlow(services: self.services)
    
        Flows.whenReady(flow1: userFlow) { [unowned self] root in
            DispatchQueue.main.async {
                 self.rootViewController.present(root, animated: true)
            }
        }
    
        return .one(flowContributor: .contribute(withNextPresentable: userFlow, withNextStepper: UserStepper()))
    }
    
    private func navigatePostDetail() -> FlowContributors {
               let viewModel = PostDetailViewModel()
                     
             let viewController = PostDetailController.instantiate(withViewModel: viewModel,andServices: self.services)
                            
                            self.rootViewController.pushViewController(viewController, animated: true)
                            let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
                            return .one(flowContributor: nexFlowItem)
          }
    
    private func navigateChat() -> FlowContributors {
           let chatFlow = ChatFlow(services: self.services)
       
           Flows.whenReady(flow1: chatFlow) { [unowned self] root in
               DispatchQueue.main.async {
                    self.rootViewController.present(root, animated: true)
               }
           }
       
           return .one(flowContributor: .contribute(withNextPresentable: chatFlow, withNextStepper: ChatStepper()))
       }
    
    private func navigatePost(with image : [Image]) -> FlowContributors {
        let controller = PostViewModel()
        
        controller.image = image
        let viewController = PostController.instantiate(withViewModel: controller,andServices: self.services)
               
               self.rootViewController.pushViewController(viewController, animated: true)
               let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
               return .one(flowContributor: nexFlowItem)
        
    }
}

class AppStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    var initialStep: Step {
        return AppStep.mainPage
    }
}


