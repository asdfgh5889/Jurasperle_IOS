//
//  LogoutPostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/20/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class LogoutPostData: PostDataProtocol, HasHeaderItems
{
    func getPath() -> String
    {
        return JurasperleAPI.logout
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
