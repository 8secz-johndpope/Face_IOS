//
//  ViewController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 07/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Reusable
import SnapKit
import KYDrawerController
import SwiftEventBus
class ViewController: UITabBarController , UITabBarControllerDelegate , StoryboardBased, ViewModelBased {
    
    var viewModel: AppViewModel!

    var feedPage : FeedController!
    var rankPage : RankController!
    var choicePage : ChoiceController!
    
    var drawerController : KYDrawerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.feedPage = FeedController.instantiate()
        self.choicePage = ChoiceController()
        self.rankPage = RankController.instantiate()
        
        self.feedPage.viewModel = self.viewModel
        
        initView()
    }
    
    func initView(){
        viewControllers = [feedPage ,choicePage, rankPage]
        
        
        feedPage.tabBarItem  = makeTabBarItems("feed")
        choicePage.tabBarItem = makeTabBarItems("favorite")
        rankPage.tabBarItem  = makeTabBarItems("diamond")
        
        SwiftEventBus.onMainThread(self, name: CodeUtils.EventBus.DRAWER_CLICK) { (result) in
            
            self.drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    func makeTabBarItems(_ image : String) -> UITabBarItem{
        let feedTabarItem = UITabBarItem(title: nil, image: UIImage(named: image), selectedImage: nil)
        
        feedTabarItem.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
        
        return feedTabarItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        SwiftEventBus.unregister(self)
    }
}

