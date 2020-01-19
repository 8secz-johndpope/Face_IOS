//
//  CommonUtils.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 02/11/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

class CommonUtils {
    
    static func getCurrentTimeStampe() -> Int64 {
       return Int64(NSDate().timeIntervalSince1970 * 1000)
    }
    
}
