//
//  UserGlobalData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

enum Language
{
    case en
    case ru
}

struct UserGlobalDataKeys
{
    static let login = "userLogin"
    static let password = "userPassword"
    static let userId = "userId"
    static let name = "name"
    static let email = "email"
    static let phone = "phone"
    static let viewedProducts = "viewedProducts"
}

class UserGlobalData
{
    static var language: Language = .ru
    static var auth: Authorization!
    static var login: String?
    static var password: String?
    
    static func logout()
    {
        NetworkController.logout(LogoutPostData()) { (_: GeneralResponse?) in }
        saveUserData(login: "", password: "")
    }
    
    static func login(_ username: String, _ password: String, _ onFailre: @escaping () -> Void, _ onSuccess: ( (Authorization) -> Void)?, _ logLogin: Bool = false)
    {
        
        NetworkController.login(LoginPostData(username, password))
        { (auth: Authorization?) -> Void in
            DispatchQueue.main.sync {
                guard let auth = auth, auth.error.errorCode == 0 else
                {
                    onFailre()
                    return
                }
                
                UserGlobalData.auth = auth
                onSuccess?(auth)
                saveUserData(login: username, password: password)
            }
        }
    }
    
    static func saveUserData(login: String, password: String)
    {
        UserGlobalData.login = login
        UserGlobalData.password = password
        
        let defaults = UserDefaults.standard
        defaults.set(login, forKey: UserGlobalDataKeys.login)
        defaults.set(password, forKey: UserGlobalDataKeys.password)
    }
    
    static func loadUserData( _ onFailre: @escaping () -> Void, _ onSuccess: ( (Authorization) -> Void)?)
    {
        let defaults = UserDefaults.standard
        if let login = defaults.string(forKey: UserGlobalDataKeys.login)
        {
            UserGlobalData.login = login
        }
        
        if let password = defaults.string(forKey: UserGlobalDataKeys.password)
        {
            UserGlobalData.password = password
        }
        
        login(login ?? "", password ?? "", onFailre, onSuccess)

    }
}
