//
//  ResetController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 10/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
class ResetController : BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased  {
    
    var viewModel : ResetViewModel!
    @IBOutlet weak var NoticeTextView: UITextView!
    
    @IBOutlet weak var EmailIdField: UICTextField!
    
    @IBOutlet weak var EmailCodeField: UICTextField!
    
    @IBOutlet weak var NextStepLabel: UICLabel!
    
    let disposeBag = DisposeBag()
    
    let nextGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    
    func initView() {
        baseProtocol = self
        setTitleValue("ResetPassword".localized)
        
        NoticeTextView.text = "ResetNotice".localized
        NextStepLabel.text = "NextStep".localized
        
        NextStepLabel.addGestureRecognizer(nextGesture)
        nextGesture.rx.event.bind { (_) in
            self.viewModel.doPasswordChangePage()
        }.disposed(by: disposeBag)
        
    }
    
    func onFinish() {
        self.viewModel.doFinish()
    }
    
    func onNext() {
        
    }
}
