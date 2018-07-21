//
//  ConversationRoomPostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/17/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ConversationRoomPostData: PostDataProtocol, HasHeaderItems, HasPagination, HasQueryItems
{
    var conversationId: Int
    var pageMetadata: PageMetadata?
    var page = 0
    init(_ conversationId: Int)
    {
        self.conversationId = conversationId
    }
    
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
    
    func getQueryItems() -> HasQueryItems.QueryItems?
    {
        let page = (pageMetadata?.currentPage ?? 0) + 1
        return [URLQueryItem(name: "page", value: page.description)]
    }
    
    func getPath() -> String
    {
        return "\(JurasperleAPI.messages)/\(self.conversationId)"
    }
}
