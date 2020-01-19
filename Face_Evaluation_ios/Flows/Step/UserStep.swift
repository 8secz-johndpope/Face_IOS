//
//  UserStep.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 13/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxFlow

enum UserStep: Step {
    // login
    case loginPage
    case dismiss
    case ResetPage
    case PasswordChangePage
    case SignUpPage
}
