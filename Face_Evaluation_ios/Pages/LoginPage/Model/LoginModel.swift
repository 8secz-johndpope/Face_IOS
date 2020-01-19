//
//  LoginModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 10/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

struct LoginModel : Codable {
    var status : Int? = 0
    var message : String? = ""
    var email : String? = ""
    var token : String? = ""
    var userId : Int64? = -1
}
