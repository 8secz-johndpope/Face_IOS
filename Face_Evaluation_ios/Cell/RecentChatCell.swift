//
//  RecentChatCell.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 26/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import UIKit

class RecentChatCell: UICollectionViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }

    
    func initData(){
        title.text = "test"
        message.text = "message"
        date.text = "4시간전"
    }
}
