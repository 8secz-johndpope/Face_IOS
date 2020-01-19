//
//  PostDetailViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 17/11/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

import RxFlow
import RxSwift
import RxCocoa
import PromiseKit
import AwaitKit
class PostDetailViewModel : Stepper , ServicesViewModel {
    let steps = PublishRelay<Step>()
    let disposeBag = DisposeBag()
    
    
    typealias Services = HasApiService
    
    var services: Services!
   
}
