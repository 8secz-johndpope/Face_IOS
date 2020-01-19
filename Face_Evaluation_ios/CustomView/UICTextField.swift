//
//  UICUilabel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit
@IBDesignable

class UICTextField : UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: leftPadding, height: self.frame.height))
            
            self.leftView = leftView
            self.leftViewMode = .always
        }
    }
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: rightPadding, height: self.frame.height))
            
            self.rightView = leftView
            self.rightViewMode = .always
        }
    }
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor = .lightGray {
        didSet {
            let placeholderStr = placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    
}

