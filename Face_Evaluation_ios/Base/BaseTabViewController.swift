//
//  BaseTabViewController.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 15/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import SnapKit
import Gallery
class BaseTabViewController : UIViewController {
    var headerView : MainHeaderView? = nil
    var baseProtocol : BaseTapDetailProtocol? = nil
    lazy var cameraButton : UIView = {
        let view = UIView()
        let imageView = UICImageView()
        imageView.image = UIImage(named: "camera");
        imageView.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 32
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(hexString: "#efefef").cgColor
        view.backgroundColor = UIColor.init(hexString: "#50BCDF")
        view.addSubview(imageView)
        
        
        imageView.snp.makeConstraints({ (make) in
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.centerY.centerX.equalTo(view)
        })
        
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = MainHeaderView(frame: self.view.frame)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(doFinish))
        headerView?.imageView?.isUserInteractionEnabled = true
        headerView?.imageView?.addGestureRecognizer(singleTap)
        
        self.view.addSubview(headerView!)
        self.view.addSubview(cameraButton)
        
        self.cameraButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doGallery)))
        
        setConstraint()
    }
    
    @objc func doGallery(){
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 1
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    @objc func doFinish() {
        baseProtocol?.onFinish()
    }
    func setTitleValue(_ value : String){
        headerView?.titleConts = value
    }
    
    func setConstraint(){
        headerView!.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
            }
            
            
            make.left.right.equalTo(self.view)
            make.height.equalTo(100)
        }
        
        
        cameraButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).inset(100)
            make.right.equalTo(self.view).inset(15)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
    }
    
}

extension BaseTabViewController : GalleryControllerDelegate {
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        
        baseProtocol?.onSelectImage(image: images)
        
        dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        baseProtocol?.onSelectVideo(video: video)
        
        dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        baseProtocol?.onSelectImage(image: images)
         
         dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
    
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
