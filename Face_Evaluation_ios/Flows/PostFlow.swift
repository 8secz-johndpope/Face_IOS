//
//  PostFlow.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 13/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift

class PostFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: PostController = {
        let viewController = PostController()
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
        case .Complete :
            return navigateBack()
        default:
            return .none
            
        }
    }
    

    
    private func navigateComplete() -> FlowContributors {
        if let rootViewController = self.rootViewController.presentedViewController {
            rootViewController.dismiss(animated: true)
        }else {
            self.rootViewController.dismiss(animated: true)
        }
        return .none
    }
    
    private func navigateBack() -> FlowContributors {
        self.rootViewController.dismiss(animated: true)
        return .none
    }
}
