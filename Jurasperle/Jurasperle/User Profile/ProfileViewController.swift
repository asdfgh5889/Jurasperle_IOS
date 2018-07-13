//
//  ProfileViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userDateOfBirth: UITextField!
    
    @IBOutlet weak var userWorkPlace: UITextField!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var webPageLink: UITextField!
    @IBOutlet weak var Ampula: UITextField!
    @IBOutlet weak var userBiography: UITextView!
    @IBOutlet weak var userPhotoGalleryCollection: UICollectionView!
    @IBOutlet weak var userGalleryImageCell: UIImageView!
    @IBOutlet weak var bolkedUsersList: UITableView!
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var userOldPassword: UITextField!
    @IBOutlet weak var userNewPassword: UITextField!
    @IBOutlet weak var passwordConfirimation: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBOutlet weak var cancelButtonAction: UIButton!
    
    @IBOutlet weak var saveButtonAction: UIButton!
    
}
