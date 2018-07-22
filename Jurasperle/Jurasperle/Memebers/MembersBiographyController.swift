//
//  MembersBiographyController.swift
//  Jurasperle
//
//  Created by Dragon on 7/2/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit
import Kingfisher
class MembersBiographyController: UIViewController {
    @IBOutlet weak var ImageCell: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberDateOfBirth: UILabel!
    @IBOutlet weak var memberWorkPlace: UILabel!
    @IBOutlet weak var memberWebPage: UILabel!
    @IBOutlet weak var memberAmpula: UILabel!
    @IBOutlet weak var memberEmail: UILabel!
    @IBOutlet weak var memberBio: UITextView!
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewElements()
        setMemberData()
    }
    
    func setMemberData()
    {
        
        ImageCell.kf.setImage(with: URL(string: user.photoURLStr!))
        memberName.text = user.name.text
        memberWorkPlace.text = user.workPlace.text
        
        memberAmpula.text += user.ampula
       
        if user.bio.text != nil
        {
            memberBio.text = user.bio.text
        }
        else
        {
            memberBio.text = "Этот участник не добавил автобиографию"
        }
        
        memberDateOfBirth.text = user.birthDate
        memberWebPage.text = user.website
        memberEmail.text = user.email
        
    }
    
    func  setViewElements()
    {
        ImageCell.layer.cornerRadius = ImageCell.frame.height/2
        ImageCell.clipsToBounds = true
    }
}
