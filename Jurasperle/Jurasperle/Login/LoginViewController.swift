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
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        
        if loginField.text == "1" && passwordField.text == "1"
        {
            print("success")
        } else
        {
//            let alert = UIAlertController(title: "Ошибка", message: "Неверные данные !", preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .cancel, handler: {{ (action: UIAlertAction) in
//                alert.dismiss(animated: true, completion: nil)
//                }}())
//            alert.addAction(action)
//            self.present(alert, animated: true, completion: nil)
            print("Failed")
        }
    }
    
}
