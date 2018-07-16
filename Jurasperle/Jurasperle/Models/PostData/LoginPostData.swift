//
//  LoginPostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class LoginPostData: PostDataProtocol, HasQueryItems
{
    var username: String
    var password: String
    
    init(_ username: String, _ password: String)
    {
        self.username = username
        self.password = password
    }
    
    func getMethod() -> HTTPMethods
    {
        return .post
    }
    
    func getQueryItems() -> QueryItems?
    {
        return [
            URLQueryItem(name: QueryItemNames.username, value: self.username),
            URLQueryItem(name: QueryItemNames.password, value: self.password)
        ]
    }
    
    func getPath() -> String
    {
        return JurasperleAPI.login
    }
}
