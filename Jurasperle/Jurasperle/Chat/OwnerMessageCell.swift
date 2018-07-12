//
//  MessageTableViewCell.swift
//  Chat-Storyboard
//
//  Created by Dante Solorio on 10/11/16.
//  Copyright © 2016 iOS School Mexico. All rights reserved.
//

import UIKit

class OwnerMessageCell: UITableViewCell {

    @IBOutlet weak var ownerMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        ownerMessageLabel.textColor = .white
        ownerMessageLabel.layer.cornerRadius = 8
        ownerMessageLabel.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
