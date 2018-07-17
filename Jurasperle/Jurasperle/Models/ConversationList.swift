//
//  ConversationList.swift
//  Jurasperle
//
//  Created by Sherzod on 7/16/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ConversationList: Mapable
{
    var conversationRooms = [ConversationRoomInfo]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataArrayUnwrapper(json) else
        {
            return false
        }
        
        for convRoomJson in data
        {
            let temp = ConversationRoomInfo()
            if temp.mapData(fromJson: convRoomJson)
            {
                self.conversationRooms.append(temp)
            }
        }
        
        return true
    }
}
