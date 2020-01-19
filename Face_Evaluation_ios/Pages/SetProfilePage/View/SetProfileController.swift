//
//  SetProfileController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 13/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Gallery

class SetProfileController :  BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased {
    
    @IBOutlet weak var nickNameField: UICTextField!
    
    @IBOutlet weak var startLabel: UICLabel!
    @IBOutlet weak var fullNameField: UICTextField!
    @IBOutlet weak var aboutField: UICTextField!
  
    @IBOutlet weak var profileImageView: UICImageView!
    @IBOutlet weak var genderField: UICTextField!
    let startGestrue = UITapGestureRecognizer()
    let profileGesture = UITapGestureRecognizer()
    let disposeBag = DisposeBag()
    func onFinish() {
        self.viewModel.doFinish()
    }
    func onNext() {
        
    }
    
     var viewModel : SetProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        baseProtocol = self
        setTitleValue("SetUpProfile".localized)
        
        initView()
    }
    
    func initView() {
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(profileGesture)
        
        profileGesture.rx.event.bind { (_) in
            self.doGallery()
        }.disposed(by: disposeBag)
        
        nickNameField.rx.text.orEmpty.bind(to: viewModel._nickName).disposed(by: disposeBag)
        
         fullNameField.rx.text.orEmpty.bind(to: viewModel._fullName).disposed(by: disposeBag)
        
         genderField.rx.text.orEmpty.bind(to: viewModel._gender).disposed(by: disposeBag)
        
        aboutField.rx.text.orEmpty.bind(to: viewModel._aboutMe).disposed(by: disposeBag)
        
        viewModel.toast.subscribe {
            result in
            
            switch(result) {
                case .next(let response):
                    ModalUtils.showToast(self, response, nil, CodeUtils.string.CONFIRM, "")
                case .error(_): break
                case .completed: break
            }
            
        }.disposed(by: disposeBag)
        
        startLabel.addGestureRecognizer(startGestrue)
        startGestrue.rx.event.bind { (_) in
            self.viewModel.doSave()
        }.disposed(by: disposeBag)
        
       viewModel.response.subscribe{ event in
            switch event {
            case .next(let success):
                if success {
                    self.viewModel.doComplete()
                }else {
                     ModalUtils.showToast(self, CodeUtils.string.NETWORKFAILED, nil, CodeUtils.string.CONFIRM, "")
                }
            case .error(_):
                  ModalUtils.showToast(self, CodeUtils.string.NETWORKFAILED, nil, CodeUtils.string.CONFIRM, "")
                break
            case .completed: break
            }
        }.disposed(by: disposeBag)
    }
    
    
    func doGallery() {
       Config.tabsToShow = [.imageTab, .cameraTab]
       Config.Camera.imageLimit = 1
       let gallery = GalleryController()
       gallery.delegate = self
       present(gallery, animated: true, completion: nil)
    }
}



extension SetProfileController : GalleryControllerDelegate {
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if !images.isEmpty {
            images[0].resolve { (image) in
                self.profileImageView.image = image
                self.viewModel.representImg = image
            }
        }
    
        dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        dismiss(animated: true, completion: nil)
    }
}

