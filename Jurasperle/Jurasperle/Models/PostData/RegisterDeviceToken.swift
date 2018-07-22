//
//  RegisterDeviceToken.swift
//  Jurasperle
//
//  Created by Sherzod on 7/21/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class RegisterDeviceToken: PostDataProtocol, HasHeaderItems, HasQueryItems
{
    var token: String?
    
    init(_ token: String?)
    {
        self.token = token
    }
    
    func getPath() -> String
    {
        return JurasperleAPI.deviceToken
    }
    
    func getMethod() -> HTTPMethods
    {
        return .post
    }
    
    func getQueryItems() -> HasQueryItems.QueryItems?
    {
        return [URLQueryItem(name: "token", value: self.token)]
    }
    
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        return header
    }
}
