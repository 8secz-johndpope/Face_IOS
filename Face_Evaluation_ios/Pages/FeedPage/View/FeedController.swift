//
//  FeedController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 13/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import Reusable
import Gallery
import SwiftEventBus
class FeedController : BaseTabViewController  , StoryboardBased , UICollectionViewDataSource , BaseTapDetailProtocol{
    func onFinish() { SwiftEventBus.post(CodeUtils.EventBus.DRAWER_CLICK)
    }
    
    func onSelectImage(image: [Image]) {
        viewModel.toPostController(image)
    }
    
    func onSelectVideo(video: Video) {
       
    }
    
    var viewModel : AppViewModel!
    
    let CELL_ID  = "Feed_Cell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    let flowLayout : UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0.0
        
        return flowLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initView()
    }
    
    func initView(){
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: CELL_ID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        baseProtocol = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath)
        
        return cell
    }
}

extension FeedController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.viewModel.movePostDetailController()
        
        
    }
    
    
}
