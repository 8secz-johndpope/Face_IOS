//
//  DrawerCell.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 21/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
import SnapKit
class DrawerCell : UIView {
    
    lazy var categoryLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(named: CodeUtils.color.COLOR_3F3F3F)
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        
    }
    
    
    func setText(_ content : String){
        self.categoryLabel.text = content
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
