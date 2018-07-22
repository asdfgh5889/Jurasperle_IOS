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
    @IBOutlet weak var userOldPassword: UITextField!
    @IBOutlet weak var userNewPassword: UITextField!
    @IBOutlet weak var passwordConfirimation: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonAction: UIButton!
    @IBOutlet weak var saveButtonAction: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var blokedUsersTable: UITableView!
    @IBOutlet var userName: UITextField!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    var blokedUsers = BlockedUsersTableViewController()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupUserData()
        self.blokedUsersTable.delegate = self.blokedUsers
        self.blokedUsersTable.dataSource = self.blokedUsers
        self.title = "Профиль"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
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
                    self.userWorkPlace.text = user?.workPlace.text
                    self.webPageLink.text = user?.website
                    self.Ampula.text = user?.ampula.text
                    self.userBiography.text = user?.bio.text
                    self.userEmail.text = user?.email
                    self.blokedUsers.setUpContacts(self.blokedUsersTable)
                    self.userName.text = user?.name.text
                }
            }
        }
     }
    
    @IBAction func blockUserSwitch(sender: UISwitch)
    {
        self.blokedUsers.blockUser(at: sender.tag)
    }
    
    fileprivate var isKeyboadyShowen: Bool = false
    @objc func keyboardNotification(notification: NSNotification)
    {
        let keyboardFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        if self.passwordConfirimation.isFirstResponder || self.userNewPassword.isFirstResponder || self.userOldPassword.isFirstResponder
        {
            if !self.isKeyboadyShowen
            {
                self.isKeyboadyShowen = true
                self.scrollView.contentOffset.y = self.scrollView.contentOffset.y + keyboardFrame.height
            }
            else
            {
                self.isKeyboadyShowen = false
                self.scrollView.contentOffset.y = self.scrollView.contentOffset.y - keyboardFrame.height
            }
        }
    }
    
    @IBAction func saveButtonAction(_ sender: Any)
    {
        let alert = UIAlertController(title: "", message: "Вы хотите все сохранить?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: {{ (action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            }}())
        let delete = UIAlertAction(title: "Да", style: .destructive, handler: {
        { (action: UIAlertAction) in
            self.blokedUsers.saveBlockedUsers()
        }}())
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}
