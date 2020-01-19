//
//  BaseViewModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 09/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//
import UIKit
protocol ViewModel {
}

protocol ServicesViewModel: ViewModel {
    associatedtype Services
    var services: Services! { get set }
}

protocol BaseViewModel: class {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}
