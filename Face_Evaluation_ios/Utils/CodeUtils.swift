//
//  CodeUtils.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 14/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

struct CodeUtils {
    
    struct EventBus {
        static let DRAWER_CLICK = "drawer_click"
        static let SEND_MESSAGE = "send_message"
        static let SEND_MESSAGE_ERROR = "send_message_error"
        static let SEND_MESSAGE_CONNECT = "send_message_connect"
        static let SEND_MESSAGE_DISCONNECT = "send_message_disconnect"
        
    }
    
    struct color {
        static let COLOR_3F3F3F = "3F3F3F"
        static let COLOR_AAAAAA = "aaaaaa"
        static let COLOR_EFEFEF = "efefef"
    }
    
    struct string {
        static let CHATS = "Chats".localized
        static let POST = "Post".localized
        static let SAVE = "Save".localized
        static let TAGTITLE = "TagTitle".localized
        static let TAGMESSAGE = "TagMessage".localized
        static let TAGHINT = "TagHint".localized
        
        static let LINKTITLE = "LinkTitle".localized
        static let LINKMESSAGE = "LinkMessage".localized
        static let LINKHINT = "LinkHint".localized
        
        static let CONFIRM = "Confirm".localized
        static let CANCEL = "Cancel".localized
        static let ADDTAGS = "AddTags".localized
        static let ADDLINKS = "AddLinks".localized
        static let TITLEHINT = "TitleHint".localized
        static let NETWORKFAILED = "NetworkFailed".localized
        static let NETWORKSUCCESS = "NetworkSuccess".localized
        static let PROFILEIMAGESET = "ProfileImageSet".localized
        static let NAMECHECK = "NameCheck".localized
        static let EMAILCHECK = "EmailCheck".localized
        static let PASSWORDCHECK = "PasswordCheck".localized
        static let NICKNAMECHECK = "NickNameCheck".localized
        static let GENDERCHECK = "GenderCheck".localized
        static let INTRODUCECHECK = "IntroduceCheck".localized
        static let CREATEACCOUNT = "CreateAccount".localized
        static let SIGNUPNOTICE = "SignUpNotice".localized
        static let SIGNUPPERM = "SignUpPerm".localized
        static let INPUTVALID = "InputValid".localized
        static let LOGINFAILED = "LoginFailed".localized
    }
    
    struct parameter {
        static let EMAIL = "email"
        static let PASSWORD = "password"
        static let FILES = "files"
        static let STORY_IMG = "story_img"
        static let STORY_DATE = "story_date"
        static let STORY_TITLE = "story_title"
        static let STORY_TAG = "story_tag"
        static let STORY_MESSAGE = "story_message"
        static let NAME = "name"
        static let NICKNAME = "nickname"
        static let GENDER = "gender"
        static let MESSAGE = "message"
        static let CREATEAT = "createAt"
        static let ROLE = "role"
        
    }
    
    struct parser {
        static let FILENAME = "filename"
        
    }
    
    struct common {
        static let ROLE_USER = "ROLE_USER"
        
    }
}
