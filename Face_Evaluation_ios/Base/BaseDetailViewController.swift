//
//  BaseDetailViewController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import SnapKit
class BaseDetailViewController : UIViewController {
    var headerView : HeaderView? = nil
    var baseProtocol : BaseDetailProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = HeaderView(frame: self.view.frame)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(doFinish))
        headerView?.imageView?.isUserInteractionEnabled = true
        headerView?.saveLabel?.isUserInteractionEnabled = true
        headerView?.imageView?.addGestureRecognizer(singleTap)
        headerView?.saveLabel?.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(doNext))
        )
        
        self.view.addSubview(headerView!)
        setConstraint(headerView!)
    }
    
    @objc func doFinish() {
        baseProtocol?.onFinish()
    }
    
    @objc func doNext() {
        baseProtocol?.onNext()
    }
    
    func setTitleValue(_ value : String){
        headerView?.titleConts = value
    }
    
    func setNextStepValue(_ value : String){
        headerView?.nextStep = value
    }
    
    func setConstraint(_ view : HeaderView){
        view.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
            }
            
            make.left.right.equalTo(self.view)
            make.height.equalTo(100)
        }
    }
    
}
