//
//  ModalUtils.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 04/11/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import CleanyModal
import PromiseKit

class ModalUtils {
    
    
    static func showTextModal(_ view : UIViewController , _ title : String , _ message : String, _ placeholder : String , _ action : String , _ cancel : String , completion :  @escaping (String) -> Void ){
        
        let alertConfig = CleanyAlertConfig(
            title: title,
            message: message,
            iconImgName: nil)
        let alert = CleanyAlertViewController(config: alertConfig)
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.font = UIFont.systemFont(ofSize: 12)
            textField.autocorrectionType = .no
            textField.keyboardType = .default
            textField.keyboardAppearance = .dark
        }
        
        alert.addAction(title: action, style: .default, handler: { action in
            completion(alert.textFields?.first?.text ?? "")
        })
        alert.addAction(title: cancel, style: .cancel)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    
    static func showToast(_ controller : UIViewController , _ title : String? , _ message : String? , _ ok : String , _ cancel : String ) {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)


        if !ok.isEmpty {
            let okAction = UIAlertAction(title: ok, style: .default, handler : nil )

            
            alert.addAction(okAction)
        }
        
        if !cancel.isEmpty {
            let cancel = UIAlertAction(title: cancel, style: .cancel, handler : nil)
          
            alert.addAction(cancel)
        }
      
        controller.present(alert, animated: true, completion: nil)
    }
}
