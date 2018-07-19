//
//  BlockedUsers.swift
//  Jurasperle
//
//  Created by Sherzod on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class BlockedUsers: Mapable, JsonDecodable
{
    var blockedUsersId = [Int]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataArrayUnwrapper(json) else
        {
            return false
        }
        
        for idJson in data
        {
            if let id = Utilities.ToInt(from: idJson)
            {
                self.blockedUsersId.append(id)
            }
        }
        
        return true
    }
    
    func getJsonData() -> Any
    {
        return self.blockedUsersId
    }
}
