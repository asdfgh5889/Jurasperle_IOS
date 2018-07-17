//
//  ConversationRoom.swift
//  Jurasperle
//
//  Created by Sherzod on 7/16/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ConversationRoomInfo: Mapable
{
    var id: Int?
    var title: String?
    var logoURLStr: String?
    var unreadMessagesCount: Int = 0
    var lastMessageTime: String?
    var isP2P: Bool = true
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return false
        }
        var data = JurasperleAPI.dataUnwrapper(json) ?? jsonDic
        
        self.id = Utilities.ToInt(from: data["id"])
        self.title = Utilities.ToString(from: data["title"])
        self.logoURLStr = Utilities.ToString(from: data["logo"])
        self.unreadMessagesCount = Utilities.ToInt(from: data["unread_messages_count"]) ?? 0
        self.lastMessageTime = Utilities.ToString(from: data["last_message_time"])
        self.isP2P = Utilities.ToBool(fron: data["isP2P"]) ?? true
        
        return true
    }
}
