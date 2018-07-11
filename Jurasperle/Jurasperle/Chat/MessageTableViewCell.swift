//
//  MessageTableViewCell.swift
//  Chat-Storyboard
//
//  Created by Dante Solorio on 10/11/16.
//  Copyright © 2016 iOS School Mexico. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
