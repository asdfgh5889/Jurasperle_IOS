//
//  MessagePostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/17/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class MessagePostData: PostDataProtocol, HasHeaderItems, HasQueryItems
{
    var text: String?
    var conversationId: Int
    
    init(_ text: String?, _ roomId: Int)
    {
        self.text = text
        self.conversationId = roomId
    }
    
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        
        return header
    }
    
    func getQueryItems() -> HasQueryItems.QueryItems?
    {
        var queryItems = QueryItems()
        queryItems.append(URLQueryItem(name: "message", value: self.text))
        return queryItems
    }
    
    func getMethod() -> HTTPMethods
    {
        return .post
    }
    
    func getPath() -> String
    {
        return "\(JurasperleAPI.conversations)/\(self.conversationId)"
    }
}
