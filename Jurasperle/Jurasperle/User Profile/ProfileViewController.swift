//
//  ProfileViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{
    @IBOutlet weak var userDateOfBirth: UITextField!
    @IBOutlet weak var userWorkPlace: UITextField!
    @IBOutlet weak var webPageLink: UITextField!
    @IBOutlet weak var Ampula: UITextField!
    
    @IBOutlet weak var userEmail: UITextField!
    
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
    @IBOutlet weak var cancelButtonAction: UIButton!
    @IBOutlet weak var saveButtonAction: UIButton!
    var blokedUsers = BlockedUsersTableViewController()
    @IBOutlet var blokedUsersTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupUserData()
        
    
    }
    
    func setupUserData()
    {
        ViewLoader.showLoaderView(for: self.view)
        let pd = UserProfilePostData()
        NetworkController.getUserProfile(pd) { (user: User?) in
            DispatchQueue.main.sync {
                ViewLoader.hideLoaderView(for: self.view)
                if user != nil
                {
                    self.userDateOfBirth.text = user?.birthDate
                    self.userWorkPlace.text = user?.workPlace.ruString
                    self.webPageLink.text = user?.website
                    self.Ampula.text = user?.ampula.ruString
                    if user?.bio.ruString != nil
                    {
                        self.userBiography.text = user?.bio.ruString
                    }
                    self.userEmail.text = user?.email
                    self.blokedUsersTable.delegate = self.blokedUsers
                    self.blokedUsersTable.dataSource = self.blokedUsers
                
                }
            }
        }
     }
    
    
}
