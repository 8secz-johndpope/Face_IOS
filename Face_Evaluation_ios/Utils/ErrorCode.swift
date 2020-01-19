//
//  ErrorCode.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 09/11/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

enum ErrorCode : Error {
    case RESPONSE_STATE_ERROR
    case RESPONSE_DATA_NULL_ERROR
    case RESPONSE_HTTP_STATUS_CODE_ERROR
    case RESPONSE_PARSE_ERROR
}
