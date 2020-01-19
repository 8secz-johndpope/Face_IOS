//
//  UICTextView.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 26/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
class UICTextView : UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
}


