//
//  Partner.swift
//  Jurasperle
//
//  Created by Sherzod on 7/14/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class Partner: Mapable
{
    var id: Int?
    var title = LString()
    var address = LString()
    var coverImageURLStr: String?
    var phonenumber: String?
    var website: String?
    var logoURLStr: String?
    var holdDates: String?
    
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
        self.address.mapData(fromJson: data["address"])
        self.coverImageURLStr = Utilities.ToString(from: data["cover_image"])
        self.phonenumber = Utilities.ToString(from: data["phone_number"])
        self.website = Utilities.ToString(from: data["web_site"])
        self.logoURLStr = Utilities.ToString(from: data["logo"])
        self.holdDates = Utilities.ToString(from: data["hold_dates"])
        
        return true
    }
}
