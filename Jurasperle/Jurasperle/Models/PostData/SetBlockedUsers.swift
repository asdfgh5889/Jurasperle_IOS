//
//  SetBlockedUsers.swift
//  Jurasperle
//
//  Created by Sherzod on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class SetBlockedUsersPostData: PostDataProtocol, HasHeaderItems, HasJsonBody
{
    var blockedUsers: BlockedUsers
    
    init(_ blockedUsers: BlockedUsers)
    {
        self.blockedUsers = blockedUsers
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
        return self.blockedUsers.getJsonData()
    }
}
