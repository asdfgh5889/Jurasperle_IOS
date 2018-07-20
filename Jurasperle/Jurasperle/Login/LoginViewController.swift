//
//  LoginViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class LoginViewController: KeyboardManagedViewController
{

    @IBOutlet weak var loginField: KMUITextField!
    @IBOutlet weak var passwordField: KMUITextField!
    @IBOutlet weak var authView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    var isLauchScreen: Bool = false
    var goToHomePage: Bool = true
    var viewControllerOnBack: UIViewController?
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        authView.isHidden = isLauchScreen
        submitButton.isHidden = isLauchScreen
        
        if isLauchScreen
        {
            ViewLoader.showLoaderView(for: self.view)
        }
    }
    
    override func viewDidLoad()
    {
        self.textFields.append(self.loginField)
        self.textFields.append(self.passwordField)
        self.onReturn = loginButtonAction
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        if isLauchScreen
        {
            ViewLoader.hideLoaderView(for: self.view)
        }
    }
    
    @IBAction func loginButtonAction()
    {
        ViewLoader.showLoaderView(for: self.view)
        UserGlobalData.login(self.loginField.text ?? "", self.passwordField.text ?? "", self.onFailure, self.onSuccess)
    }
  
    private func onSuccess(_ auth: Authorization?) -> Void
    {
        ViewLoader.hideLoaderView(for: self.view)
        self.performSegue(withIdentifier: "goMainView", sender: self)
    }
    
    private func onFailure() -> Void
    {
        let alert = UIAlertController(title: "Неверные данные", message: "Не верный логин или пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: {{ (action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            }}())
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
