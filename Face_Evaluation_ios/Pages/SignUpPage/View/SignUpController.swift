//
//  SignUpController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 12/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

class SignUpController : BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased {
    
    var viewModel : SignUpViewModel!
    
    @IBOutlet weak var passwordField: UICTextField!
    @IBOutlet weak var nextLabel: UICLabel!
    @IBOutlet weak var permLabel: UICLabel!
    @IBOutlet weak var confirmPasswordField: UICTextField!
    @IBOutlet weak var emailField: UICTextField!
    @IBOutlet weak var noticeTextView: UITextView!
    
    let disposeBag = DisposeBag()
    let nextGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView(){
        baseProtocol = self
        setTitleValue(CodeUtils.string.CREATEACCOUNT)
        
        noticeTextView.text = CodeUtils.string.SIGNUPNOTICE.localized
        permLabel.text = CodeUtils.string.SIGNUPPERM.localized
        
        nextLabel.addGestureRecognizer(nextGesture)
        nextGesture.rx.event.bind { (_) in
            do {
                guard
                    !(self.emailField.text!.isEmpty),
                    !(self.passwordField.text!.isEmpty) ,
                    !(self.confirmPasswordField.text!.isEmpty) ,
                    self.passwordField.text == self.confirmPasswordField.text else {
                    
                        ModalUtils.showToast(self, CodeUtils.string.INPUTVALID, nil, CodeUtils.string.CONFIRM, "")
                    
                    return
                }
                
                self.viewModel.doSetProfilePage(
                    self.emailField.text!,
                    self.passwordField.text!
                )
            }catch {
                print(error)
            }
        }.disposed(by: disposeBag)
    }
    
    
    func onFinish() {
        self.viewModel.doFinish()
    }
    
    func onNext() {
        
    }
    
}
