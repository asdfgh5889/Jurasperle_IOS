//
//  File.swift
//  Jurasperle
//
//  Created by Dragon on 7/12/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class OthersMessageCell: UITableViewCell
{
    @IBOutlet weak var othersMessageLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
       
        othersMessageLabel.textColor = .white
        othersMessageLabel.layer.cornerRadius = 5
        othersMessageLabel.layer.masksToBounds = true
    }
}
