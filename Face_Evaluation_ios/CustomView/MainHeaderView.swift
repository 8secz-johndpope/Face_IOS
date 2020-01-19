//
//  XibMainHeader.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 15/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit

class MainHeaderView: UIView {
    private let xibName = "MainHeaderXib"
    
    var label : UILabel? = nil
    var imageView : UIImageView? = nil
    var titleConts : String = "Title" {
        willSet(value) {
            label?.text = value
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        
        
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        
        label = view.viewWithTag(2) as? UILabel
        imageView = view.viewWithTag(1) as? UIImageView
        label?.text = titleConts
        self.addSubview(view)
    }
}
