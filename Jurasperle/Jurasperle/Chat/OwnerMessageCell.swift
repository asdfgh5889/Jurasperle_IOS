//
//  MessageTableViewCell.swift
//  Chat-Storyboard
//
//  Created by Dante Solorio on 10/11/16.
//  Copyright © 2016 iOS School Mexico. All rights reserved.
//

import UIKit

class OwnerMessageCell: UITableViewCell
{

    @IBOutlet weak var ownerMessageLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
     
        ownerMessageLabel.textColor = .white
        ownerMessageLabel.layer.cornerRadius = 5
        ownerMessageLabel.layer.masksToBounds = true
    }
}
