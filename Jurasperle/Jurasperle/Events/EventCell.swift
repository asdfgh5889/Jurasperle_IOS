//
//  EventCell.swift
//  Jurasperle
//
//  Created by Dragon on 7/21/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
   
    @IBOutlet weak var eventCover: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    override func awakeFromNib() {
        //eventWebView.delegate = self
     }
    
}
