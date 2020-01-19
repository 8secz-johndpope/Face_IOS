//
//  RecentChatController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 21/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import RxFlow
import RxSwift
import RxCocoa
class RecentChatController :BaseDetailViewController , BaseDetailProtocol , StoryboardBased, ViewModelBased {
    var viewModel: RecentChatViewModel!
       
    func onNext() {
        
    }

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let CELL_ID = "RecentChatCell"
    func onFinish() {
        viewModel.doFinish()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseProtocol = self
        
        setupCollectionViewItemSize()
        initView()
        viewModel.initData()
    }
    
    
    func initView() {
        let nibCell = UINib(nibName: CELL_ID, bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: CELL_ID)
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

extension RecentChatController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as! RecentChatCell
        
        cell.initData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.nextStep(1 , "leegunwook")
    }
}
