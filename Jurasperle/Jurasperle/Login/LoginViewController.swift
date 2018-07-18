//
//  LoginViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var goToHomePage: Bool = true
    var viewControllerOnBack: UIViewController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any)
    {
        let pd = LoginPostData(self.loginField.text ?? "", self.passwordField.text ?? "")
        NetworkController.login(pd) { (auth: Authorization?) in
            DispatchQueue.main.sync {
                if auth != nil
                {
                    if JurasError.init().errorCode == 0
                    {
                        UserGlobalData.auth = auth
                        self.performSegue(withIdentifier: "goMainView", sender: self)
                    }
                    else
                    {
                        self.onFailure()
                    }
                }
                else
                {
                    self.onFailure()
                }
            }
        }
        
      
        
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
