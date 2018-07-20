//
//  Message.swift
//  Jurasperle
//
//  Created by Sherzod on 7/17/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ChatMessage: Mapable
{
    var id: Int?
    var text: String?
    var isImage: Bool = false
    var recordTime: String?
    var senderUserId: Int?
    var senderProfile: User?
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return false
        }
        var data = JurasperleAPI.dataUnwrapper(json) ?? jsonDic
        
        self.id = Utilities.ToInt(from: data["id"])
        self.isImage = Utilities.ToBool(fron: data["is_image"]) ?? false
        self.recordTime = Utilities.ToString(from: data["record_time"])
        self.senderUserId = Utilities.ToInt(from: data["user_id"])
        self.text = Utilities.ToString(from: data["text"])
        
        let tempUser = User()
        if tempUser.mapData(fromJson: data["profile"])
        {
            self.senderProfile = tempUser
        }
        
        return true
    }
}
