//
//  Authorization.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class Authorization: Mapable
{
    var error = JurasError()
    var id: Int?
    var name: String?
    var apiToken: String?
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else {
            return false
        }
        
        self.error.mapData(fromJson: json)
        
        
        guard let data = jsonDic["data"] as? [String: Any] else {
            return false
        }
        
        self.id = Utilities.ToInt(from: data["id"])
        self.name = Utilities.ToString(from: data["name"])
        self.apiToken = Utilities.ToString(from: data["api_token"])
        
        return true
    }
}
