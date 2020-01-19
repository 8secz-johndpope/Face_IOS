//
//  LoginFlow.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 13/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift
class UserFlow: Flow {
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
        case .loginPage:
            return navigateLogin()
        case .dismiss:
            return navigateComplete()
        case .ResetPage:
            return navigateResetPage()
        case .PasswordChangePage:
            return navigatePasswordChangePage()
        case .SignUpPage:
            return navigateSignUpPage()
        case .SetUpProfile(let email , let password):
            return navigateSetProfilePage(email , password)
        case .Complete :
            return navigateBack()
        default:
            return .none
            
        }
    }
    
    private func navigateLogin() -> FlowContributors {
        let viewController = LoginController.instantiate(withViewModel: LoginViewModel(),
                                                         andServices: self.services)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
        return .one(flowContributor: nexFlowItem)
    }
    
    private func navigateComplete() -> FlowContributors {
        if let rootViewController = self.rootViewController.presentedViewController {
            rootViewController.dismiss(animated: true)
        }else {
            self.rootViewController.popViewController(animated: true)
        }
        return .none
    }
    
    private func navigateBack() -> FlowContributors {
        self.rootViewController.dismiss(animated: true)
        return .none
    }

    
    private func navigateResetPage() -> FlowContributors {
        let viewController = ResetController.instantiate(withViewModel: ResetViewModel(),
                                                         andServices: self.services)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
        return .one(flowContributor: nexFlowItem)
    }
    
    private func navigatePasswordChangePage() -> FlowContributors {
        let viewController = PasswordChangeController.instantiate(withViewModel: PasswordChangeViewModel(),
                                                                  andServices: self.services)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
        return .one(flowContributor: nexFlowItem)
    }
    
    private func navigateSignUpPage() -> FlowContributors {
        let viewController = SignUpController.instantiate(withViewModel: SignUpViewModel(),
                                                          andServices: self.services)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
        return .one(flowContributor: nexFlowItem)
    }
    
    private func navigateSetProfilePage(_ email : String , _ password : String) -> FlowContributors {
        let viewController = SetProfileController.instantiate(withViewModel: SetProfileViewModel(),
                                                          andServices: self.services)
        
        viewController.viewModel.email = email
        viewController.viewModel.password = password
        
        self.rootViewController.pushViewController(viewController, animated: true)
        let nexFlowItem = FlowContributor.contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
        return .one(flowContributor: nexFlowItem)
    }
}

class UserStepper: Stepper {
       
       let steps = PublishRelay<Step>()
       private let disposeBag = DisposeBag()
       
       var initialStep: Step {
           return AppStep.loginPage
       }
   }
