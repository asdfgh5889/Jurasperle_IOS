//
//  ConversationRoom.swift
//  Jurasperle
//
//  Created by Sherzod on 7/17/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ConversationRoom: Mapable
{
    var messages = [ChatMessage]()
    
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
        self.messages.reverse()
        
        return true
    }
}
