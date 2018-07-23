//
//  ChangeUserProdilePostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ChangeUserProfilePostData: PostDataProtocol, HasHeaderItems, HasJsonBody
{
    var newUserData: User
    
    init(_ newUserData: User)
    {
        self.newUserData = newUserData
    }
    
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        
        return header
    }
    
    func getMethod() -> HTTPMethods
    {
        return .post
    }
    
    func getPath() -> String
    {
        return JurasperleAPI.profile
    }
    
    func getJsonBody() -> HasJsonBody.JsonBody?
    {
        return self.newUserData.getJsonData()
    }
}


class ChangeUserPassword: PostDataProtocol, HasHeaderItems, HasJsonBody
{
    var old: String
    var new: String
    var confirm: String
    
    init(_ old: String, _ new: String, _ confirm: String)
    {
        self.old = old
        self.new = new
        self.confirm = confirm
    }
    func getPath() -> String
    {
        return JurasperleAPI.password
    }
    
    func getJsonBody() -> HasJsonBody.JsonBody?
    {
        var json = [String: Any]()
        json["old_password"] = self.old
        json["new_password"] = self.new
        json["new_password_confirmation"] = self.confirm
        return json
    }
    
    func getMethod() -> HTTPMethods
    {
        return .post
    }
    
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        return header
    }
}

