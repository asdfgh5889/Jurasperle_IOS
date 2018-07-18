//
//  User.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class User: Mapable
{
    var id: Int?
    var name = LString()
    var birthData: String?
    var ampula = LString()
    var workPlace = LString()
    var website: String?
    var email: String?
    var bio = LString()
    var userId: Int?
    var photo: UIImage?
    var photoURLStr: String?
    var sinceMemeber: String?
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return false
        }
        
        var data: [String: Any] = JurasperleAPI.dataUnwrapper(json) ?? jsonDic
        
        self.id = Utilities.ToInt(from: data["id"])
        self.photoURLStr = Utilities.ToString(from: data["avatar"])
        self.name.mapData(fromJson: data["name"])
        self.bio.mapData(fromJson: data["bio"])
        self.ampula.mapData(fromJson: data["ampula"])
        self.workPlace.mapData(fromJson: data["work_place"])
        self.userId = Utilities.ToInt(from: data["user_id"])
        self.birthData = Utilities.ToString(from: data["birth_date"])
        self.sinceMemeber = Utilities.ToString(from: data["member_date"])
        self.website = Utilities.ToString(from: data["web_site"])
        return true
    }
}
