//
//  Event.swift
//  Jurasperle
//
//  Created by Sherzod on 7/21/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class Event: Mapable
{
    var id: Int?
    var title = LString()
    var description = LString()
    var address = LString()
    var coverImageURLStr: String?
    var participantCount: Int?
    var holdDates = [String]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return false
        }
        var data = JurasperleAPI.dataUnwrapper(json) ?? jsonDic
        
        self.id = Utilities.ToInt(from: data["id"])
        self.title.mapData(fromJson: data["title"])
        self.description.mapData(fromJson: data["description"])
        self.address.mapData(fromJson: data["address"])
        self.coverImageURLStr = Utilities.ToString(from: data["cover_image"])
        self.participantCount = Utilities.ToInt(from: data["partcipants_count"])
        
        if let array = data["hold_dates"] as? [String]
        {
            self.holdDates.append(contentsOf: array)
        }
        
        return true
    }
}
