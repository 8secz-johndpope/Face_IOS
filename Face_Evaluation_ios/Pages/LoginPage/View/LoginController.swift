//
//  LoginController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import RxFlow
import RxSwift
import RxCocoa
class LoginController : BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased{
    
    func onFinish() {
        self.viewModel.doFinish()
    }
    
    
    var viewModel : LoginViewModel!
    
    @IBOutlet weak var loginLabel: UICLabel!
    @IBOutlet weak var passwordField: UICTextField!
    @IBOutlet weak var passwordResetLabel: UILabel!
    @IBOutlet weak var emailField: UICTextField!
    @IBOutlet weak var signUpLabel: UILabel!
    
    let disposeBag = DisposeBag()
    let tapGesture = UITapGestureRecognizer()
    let passwordResetGesture = UITapGestureRecognizer()
    let signUpGesture = UITapGestureRecognizer()
    override func viewDidLoad() {
       super.viewDidLoad()
       initView()
       initEvent()
    }
    
    func initView() {
        baseProtocol = self
        setTitleValue("Login".localized)
        
        loginLabel.addGestureRecognizer(tapGesture)
        passwordResetLabel.addGestureRecognizer(passwordResetGesture)
        signUpLabel.addGestureRecognizer(signUpGesture)
        
        passwordResetGesture.rx.event.bind { (_) in
            self.viewModel.doResetPage()
        }.disposed(by: disposeBag)
        
        tapGesture.rx.event.bind(onNext : {
            data in
            
            self.viewModel.dologin(email: self.emailField.text ?? "", password: self.passwordField.text ?? "")
        }).disposed(by: disposeBag)
        
        signUpGesture.rx.event.bind { (_) in
            self.viewModel.doSignUpPage()
        }.disposed(by: disposeBag)
    }
    
    func initEvent(){
        viewModel.loginModel.subscribe(onNext: { (model) in
            
            guard let data = model else {
                ModalUtils.showToast(self, CodeUtils.string.LOGINFAILED, nil, CodeUtils.string.CONFIRM,"")
                return
            }
            
            if (data.status == 200){
                self.viewModel.doSave(data)
            }else {
                ModalUtils.showToast(self, CodeUtils.string.LOGINFAILED, nil, CodeUtils.string.CONFIRM,"")
            }
        }).disposed(by: disposeBag)
    }
    
    
    func onNext() {
        
    }
    
    
}
