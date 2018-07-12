//
//  File.swift
//  Jurasperle
//
//  Created by Dragon on 7/12/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class OthersMessageCell: UITableViewCell {
    
    @IBOutlet weak var othersMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        othersMessageLabel.textColor = .white
        othersMessageLabel.layer.cornerRadius = 8
        othersMessageLabel.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
