//
//  AlertUtils.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 09/11/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit

class AlertUtils {
    
    static func showToast(_ controller : UIViewController , _ title : String , _ message : String , _ ok : String , _ cancel : String ) {
        
        
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
