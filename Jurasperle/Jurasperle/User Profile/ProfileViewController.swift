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
    @IBOutlet weak var userBiography: UITextField!
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

    var user: User?
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
        
        self.userName.tag = 0
        self.userDateOfBirth.tag = 1
        self.userWorkPlace.tag = 2
        self.webPageLink.tag = 3
        self.Ampula.tag = 4
        self.userEmail.tag = 5
        self.userBiography.tag = 6
        self.userOldPassword.tag = 7
        self.userNewPassword.tag = 8
        self.passwordConfirimation.tag = 9
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
                    self.user = user
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
    
    @IBAction func changeUserData(_ textField: UITextField)
    {
        switch textField.tag {
        case 0: self.user!.name += textField.text
        case 1: self.user!.birthDate = textField.text
        case 2: self.user!.workPlace += textField.text
        case 3: self.user!.website = textField.text
        case 4: self.user!.ampula += textField.text
        case 5: self.user!.email = textField.text
        case 6: self.user!.bio += textField.text
        case 7: print()
        case 8: print()
        case 9: print()
        default:
            print("no")
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
            self.saveUserProfile()
        }}())
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelProfile()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveUserProfile()
    {
        self.blokedUsers.saveBlockedUsers()
        NetworkController.changeUserProfileData(ChangeUserProfilePostData(self.user!)) { (user: User?) in
            self.user = user
        }
        
        if (self.userOldPassword.text ?? "") == UserGlobalData.password!
        {
            NetworkController.setPassword(ChangeUserPassword(self.userOldPassword.text ?? "", self.userNewPassword.text ?? "", self.passwordConfirimation.text ?? ""))
            { (_: GeneralResponse?) in
            }
        }
        self.cancelProfile()
//        else
//        {
//            let alert = UIAlertController(title: "", message: "Неверный старый пароль", preferredStyle: .alert)
//            let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: {{ (action: UIAlertAction) in
//                alert.dismiss(animated: true, completion: nil)
//                }}())
//            let delete = UIAlertAction(title: "Ок", style: .destructive, handler: {
//            { (action: UIAlertAction) in
//                self.saveUserProfile()
//                }}())
//            alert.addAction(delete)
//            alert.addAction(cancel)
//            self.present(alert, animated: true, completion: nil)
//        }
    }
}
