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
        return JurasperleAPI.user
    }
    
    func getJsonBody() -> HasJsonBody.JsonBody?
    {
        return self.newUserData.getJsonData()
    }
}
