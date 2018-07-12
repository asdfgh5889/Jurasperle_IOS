//
//  MembersCell.swift
//  Jurasperle
//
//  Created by Dragon on 7/1/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class MembersCell: UITableViewCell {

    @IBAction func sendMessageTo(_ sender: Any) {
    }
    @IBOutlet weak var sendMessage: UIButton!
    @IBOutlet weak var moreInfo: UIButton!
    @IBOutlet weak var memberImageCell: UIImageView!
    @IBOutlet weak var memberNameLable: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        memberImageCell.layer.borderWidth = 1
        memberImageCell.layer.masksToBounds = false
        memberImageCell.layer.borderColor = UIColor.black.cgColor
        memberImageCell.layer.cornerRadius = memberImageCell.frame.height/2
        memberImageCell.clipsToBounds = true
        sendMessage.clipsToBounds = true
        moreInfo.clipsToBounds = true
        sendMessage.layer.cornerRadius = 8
        moreInfo.layer.cornerRadius = 8
        sendMessage.layer.borderWidth = 1
        sendMessage.layer.borderColor = UIColor.gray.cgColor
        moreInfo.layer.borderWidth = 1
        moreInfo.layer.borderColor = UIColor.gray.cgColor
       // moreInfo.imageEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
    }
    
   
    
    class ButtonWithImage: UIButton {
        
        override func layoutSubviews() {
            super.layoutSubviews()
            if imageView != nil {
                imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
                titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
            }
        }
    }
//    view rawButtonWithImage.swift hosted with ❤ by GitHub
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
   
}
