//
//  MembersBiographyController.swift
//  Jurasperle
//
//  Created by Dragon on 7/2/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit
class MembersBiographyController: UIViewController {
   @IBOutlet weak var ImageCell: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewElements()
    }
    
    func  setViewElements()
    {
        ImageCell.layer.cornerRadius = ImageCell.frame.height/2
    }
}
