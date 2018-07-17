//
//  ConversationRoomPostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/16/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

enum ConversationRoomAction
{
    case delete
    case getInfo
}

class ConversationRoomInfoPostData: PostDataProtocol, HasHeaderItems
{
    var action: ConversationRoomAction = .getInfo
    var id: Int
    
    init(_ id: Int, _ action: ConversationRoomAction = .getInfo)
    {
        self.id = id
        self.action = action
    }
    
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        print(header)
        return header
    }
    
    func getMethod() -> HTTPMethods
    {
        return self.action == .getInfo ? .get : .delete
    }
    
    func getPath() -> String
    {
        return "\(JurasperleAPI.conversations)/\(self.id)"
    }
}
