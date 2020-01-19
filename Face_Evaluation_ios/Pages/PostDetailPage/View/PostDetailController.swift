//
//  PostDetailController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 17/11/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//
import UIKit
import Reusable
import RxFlow
import RxSwift
import RxCocoa
import SwiftEventBus
class PostDetailController : BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: PostDetailViewModel!

    typealias Services = HasApiService
          
    var services: Services!
    func onFinish() {
    }
    
    func onNext() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
    }
}
