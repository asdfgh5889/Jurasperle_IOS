//
//  ConversationRoom.swift
//  Jurasperle
//
//  Created by Sherzod on 7/16/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ConversationRoom: Mapable
{
    var id: Int?
    var title: String?
    var logoURLStr: String?
    var unreadMessagesCount: Int = 0
    var lastMessageTime: String?
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        return true
    }
}
