//
//  HeaderView.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    private let xibName = "HeaderXib"
    
    var label : UILabel? = nil
    var imageView : UIImageView? = nil
    var saveLabel  : UILabel? = nil
    
    var nextStep : String = "" {
        willSet(value) {
            saveLabel?.text = value
        }
    }
    
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
        
        label = view.viewWithTag(1) as? UILabel
        imageView = view.viewWithTag(2) as? UIImageView
        saveLabel = view.viewWithTag(3) as? UILabel
        
        
        label?.text = titleConts
        saveLabel?.text = ""
        
        self.addSubview(view)
    }
}
