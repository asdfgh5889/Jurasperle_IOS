//
//  GetBlockedIds.swift
//  Jurasperle
//
//  Created by Sherzod on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class GetBlockedUsersPostData: PostDataProtocol, HasHeaderItems
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
