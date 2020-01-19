//
//  ChatController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 26/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import RxFlow
import RxSwift
import RxCocoa
import SwiftEventBus
class ChatController : BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased {
    @IBOutlet weak var sendView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: ChatViewModel!
      
    @IBOutlet weak var messageField: UITextField!
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let CELL_USER_ID = "ChatUserCell"
    let CELL_OTHER_ID = "ChatCell"
  
    let sendEvent = UITapGestureRecognizer()
    
    func onFinish() {
        viewModel.doFinish()
    }
    
    func onNext() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseProtocol = self
        
        initView()
        setupCollectionViewItemSize()
        
        viewModel.executeGetChatList()
        
        viewModel.reloadData.asDriver(onErrorJustReturn: false).drive(onNext: { (model) in
            if model {
                self.collectionView.reloadData()
            }
        }).disposed(by: viewModel.disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.executeConnect()
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.executeDisConnect()
    }
    
        
    
    func initView() {
        
        self.messageField.rx.text.orEmpty.bind(to: viewModel._message).disposed(by: viewModel.disposeBag)
               
        setTitleValue(viewModel.sendUserName)
        
        let userCell = UINib(nibName: CELL_USER_ID, bundle: nil)
        let otherCell = UINib(nibName: CELL_OTHER_ID, bundle: nil)
        
        self.collectionView.register(userCell, forCellWithReuseIdentifier: CELL_USER_ID)
        
        self.collectionView.register(otherCell, forCellWithReuseIdentifier: CELL_OTHER_ID)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.sendView.layer.cornerRadius = 25
        
        
        self.sendView.addGestureRecognizer(sendEvent)
        self.sendEvent.rx.event.bind { (_) in
            self.viewModel.executeSendMessage()
        }.disposed(by: viewModel.disposeBag)

        
        SwiftEventBus.onBackgroundThread(self, name: CodeUtils.EventBus.SEND_MESSAGE_ERROR) { (result) in
            self.viewModel.executeConnect()
        }
    }
    
    
    private func setupCollectionViewItemSize(){
        if collectionViewFlowLayout == nil {
            let size = CGSize(width: collectionView.frame.width, height: 100)
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = size
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = 1
            collectionViewFlowLayout.minimumInteritemSpacing = 1
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
}

extension ChatController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.listOfItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_USER_ID, for: indexPath) as! ChatUserCell
              
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 150)
    }
}
    
    
