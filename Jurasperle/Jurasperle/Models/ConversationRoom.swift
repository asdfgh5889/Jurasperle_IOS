//
//  ConversationRoom.swift
//  Jurasperle
//
//  Created by Sherzod on 7/17/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ConversationRoom: Mapable, HasPagination
{
    var messages = [ChatMessage]()
    var pageMetadata: PageMetadata?
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataArrayUnwrapper(json) else
        {
            return false
        }
        
        for msgJson in data
        {
            let temp = ChatMessage()
            if temp.mapData(fromJson: msgJson)
            {
                self.messages.append(temp)
            }
        }
        
        let temp = PageMetadata()
        if temp.mapData(fromJson: json)
        {
            self.pageMetadata = temp
        }
        
        return true
    }
}
