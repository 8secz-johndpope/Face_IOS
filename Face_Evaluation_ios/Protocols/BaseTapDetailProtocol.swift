//
//  BaseTapDetailProtocol.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 13/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import Gallery

protocol BaseTapDetailProtocol {
    func onFinish()
    func onSelectImage(image :  [Image])
    func onSelectVideo(video : Video)
}
