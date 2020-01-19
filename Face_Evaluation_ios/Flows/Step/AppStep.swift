//
//  SetupStep.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 08/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow
import Gallery

enum AppStep: Step {
    // main
    case mainPage
    
    // login
    case post(image : [Image])
    case postDetail
    case user
    case loginPage
    case dismiss
    case ResetPage
    case PasswordChangePage
    case SignUpPage
    case SetUpProfile(email : String , password : String)
    case Complete
    case chats
    case chat(sendUserId : Int64 , sendUserName : String)

}
