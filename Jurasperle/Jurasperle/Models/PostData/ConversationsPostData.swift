//
//  ConversationsPostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/16/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ConversationsPostData: PostDataProtocol, HasHeaderItems
{
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        
        return header
    }
    
    func getMethod() -> HTTPMethods
    {
        return .get
    }
    
    func getPath() -> String
    {
        return JurasperleAPI.conversations
    }
}
