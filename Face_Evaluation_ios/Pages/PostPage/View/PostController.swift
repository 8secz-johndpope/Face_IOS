//
//  PostController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 12/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Gallery
import CleanyModal
import AwaitKit
import BFRImageViewer

class PostController : BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased {

    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var representImageView: UIImageView!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var tags: UILabel!
    
    let disposeBag = DisposeBag()
    let tagClick = UITapGestureRecognizer()
    let linkClick = UITapGestureRecognizer()
    let imageClick = UITapGestureRecognizer()
    var viewModel : PostViewModel!
    func onFinish() {
         self.viewModel.doFinish()
    }
    func onNext() {
        self.viewModel.doSave(self.representImageView.image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tags.isUserInteractionEnabled = true
        linkLabel.isUserInteractionEnabled = true
        representImageView.isUserInteractionEnabled = true
        
        titleField.rx.text.orEmpty.bind(to: viewModel._title).disposed(by: viewModel.disposeBag)
        
        messageTextView.rx.text.orEmpty.bind(to: viewModel._message).disposed(by: viewModel.disposeBag)
        
        setTitleValue(CodeUtils.string.POST)
        setNextStepValue(CodeUtils.string.SAVE)
        baseProtocol = self
            
        
        if !viewModel.image.isEmpty {
            viewModel.image[0].resolve { (image) in
                self.representImageView.image = image
            }
        }
        
        titleField.placeholder = CodeUtils.string.TITLEHINT
        tags.text = CodeUtils.string.ADDTAGS
        linkLabel.text = CodeUtils.string.ADDLINKS
        
        tags.addGestureRecognizer(tagClick)
        linkLabel.addGestureRecognizer(linkClick)
        representImageView.addGestureRecognizer(imageClick)
        
        imageClick.rx.event.bind { _ in
            self.moveImageView()
        }.disposed(by: disposeBag)
        
        tagClick.rx.event.bind { (_) in
            self.modalTags(CodeUtils.string.TAGTITLE,
            CodeUtils.string.TAGMESSAGE,
            CodeUtils.string.TAGHINT,
            CodeUtils.string.CONFIRM,
            CodeUtils.string.CANCEL , 0)
        }.disposed(by: disposeBag)
        
        linkClick.rx.event.bind { (_) in
            self.modalTags(CodeUtils.string.LINKTITLE,
                           CodeUtils.string.LINKMESSAGE,
                           CodeUtils.string.LINKHINT,
                           CodeUtils.string.CONFIRM,
                           CodeUtils.string.CANCEL , 1)
        }.disposed(by: disposeBag)
        
        viewModel.response.subscribe{ event in
            switch event {
            case .next(let success):
                if success {
                    self.viewModel.doFinish()
                }else {
                     ModalUtils.showToast(self, CodeUtils.string.NETWORKFAILED, nil, CodeUtils.string.CONFIRM, "")
                }
            case .error(_): break
            case .completed: break
            }
        }.disposed(by: disposeBag)
    }
    
    func moveImageView() {
        DispatchQueue.main.async {
            guard let image = self.representImageView.image else {
                return
            }
            
            let imageVC = BFRImageViewController(imageSource: [image])
          
            self.present(imageVC!, animated: true, completion: nil)
        }
    }
    
    
    func modalTags(_ tagTitle : String , _ tagMessage : String ,
                   _ tagHint : String , _ tagConfirm : String , _ cancel : String , _ type : Int) {
        
       ModalUtils.showTextModal(self, tagTitle,tagMessage , tagHint , tagConfirm , cancel
        ){ response in
            
         if response.isEmpty {
            return
         }
          if (type == 0) {
            self.tags.textColor = UIColor.init(named: CodeUtils.color.COLOR_3F3F3F)
              self.tags.text = response
              self.viewModel.tags = response
          }else {
             self.linkLabel.textColor = UIColor.init(named: CodeUtils.color.COLOR_3F3F3F)
              self.linkLabel.text = response
              self.viewModel.links = response
          }
        }
    }
    
}


