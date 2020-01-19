//
//  PasswordChangeController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 11/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

class PasswordChangeController : BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased{
    var viewModel : PasswordChangeViewModel!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var saveLabel: UICLabel!
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var confirmPasswordField: UICTextField!
    @IBOutlet weak var passwordField: UICTextField!
    
    let saveGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView(){
        baseProtocol = self
        setTitleValue("PasswordChange".localized)
        
        saveLabel.addGestureRecognizer(saveGesture)
        saveGesture.rx.event.bind { (_) in
            self.viewModel.doMain()
        }.disposed(by: disposeBag)
    }
    
    
    func onFinish() {
        self.viewModel.doFinish()
    }
    
    func onNext() {
    }
    
}
