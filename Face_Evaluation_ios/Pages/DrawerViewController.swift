//
//  DrawerViewController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 17/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import SnapKit
import KYDrawerController
class DrawerViewController: UIViewController {
    
    lazy var profile : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.gray
        iv.layer.cornerRadius = 25
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(singleTap)
        return iv
    }()
    
    lazy var nameLabel : UILabel = {
       let label = UILabel()
       
        label.textColor = UIColor(named: CodeUtils.color.COLOR_3F3F3F)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "LEE GUN WOOK"
        label.textAlignment = .left
        return label
    }()
    
    lazy var emailLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: CodeUtils.color.COLOR_AAAAAA)
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "eorjstldzm@gmail.com"
        return label
    }()
    
    lazy var topView : UIView = {
       let view = UIView()
        view.backgroundColor = .gray
       return view
    }()
    
    
    lazy var chats : DrawerCell = {
        let view = DrawerCell()
        view.setText(CodeUtils.string.CHATS)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goChats)))
        return view
    }()
    
    var viewModel: AppViewModel!
    
    //Action
    @objc func tapDetected() {
        self.viewModel.toLogin()
    }
    
    @objc func goChats() {
        self.viewModel.toChats()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.addSubview(profile)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(topView)
        view.addSubview(chats)
        
        profile.snp.makeConstraints { (make) in
            if #available(iOS 11, *) { make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(30)
            } else {
                make.top.equalTo(view).inset(30)
            }
            make.width.equalTo(50)
            make.height.equalTo(50)
            
            make.leading.equalTo(view.snp.leading).inset(30)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.profile.snp.right).inset(-15)
            make.top.equalTo(self.profile.snp.top)
            make.right.equalTo(self.view)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).inset(-10)
            make.left.equalTo(self.nameLabel.snp.left)
            make.right.equalTo(self.view)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.profile.snp.bottom).inset(-30)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(0.7)
        }
        
        chats.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.equalTo(self.view).inset(30)
            make.right.equalTo(self.view)
            make.height.equalTo(80)
        }
        
        view.backgroundColor = UIColor.white
    }
    
    @objc func didTapCloseButton(_ sender: UIButton) {
        if let drawerController = parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
        }
    }
}
