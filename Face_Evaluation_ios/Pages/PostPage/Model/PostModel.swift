//
//  PostModel.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 04/11/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

struct PostModel : Codable {
    var story_id : Int64 = 0
    var story_imgs : [String] = []
    var story_date : String = ""
    var story_title : String = ""
    var story_tag : String = ""
    var story_message : String = ""
    var story_visible : String = ""
}
