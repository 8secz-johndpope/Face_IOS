//
//  RanKCell.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 15/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
class RankCell : UICollectionViewCell {
    
    private let xibName = "RankXib"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UICImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUpView()
    }
    
    
    
    func setUpView() {
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        
        self.addSubview(view)
    }
}
