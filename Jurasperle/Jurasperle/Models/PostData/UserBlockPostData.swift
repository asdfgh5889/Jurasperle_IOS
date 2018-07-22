//
//  BlockPostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/23/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class GetBlockedUsers: PostDataProtocol, HasHeaderItems
{
    func getPath() -> String
    {
        return JurasperleAPI.blocked
    }
    
    func getMethod() -> HTTPMethods
    {
        return .get
    }
    
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        return header
    }
}

class SetBlockedUsers: PostDataProtocol, HasHeaderItems, HasJsonBody
{
    var blockedUsers: [Int]?
    
    init(_ blocked: [Int])
    {
        self.blockedUsers = blocked
    }
    
    func getPath() -> String
    {
        return JurasperleAPI.blocked
    }
    
    func getMethod() -> HTTPMethods
    {
        return .post
    }
    
    func getJsonBody() -> HasJsonBody.JsonBody?
    {
        if blockedUsers != nil
        {
            var json = [String: Any]()
            json["block"] = self.blockedUsers!
            return json
        }
        return nil
    }
    
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        return header
    }
}
