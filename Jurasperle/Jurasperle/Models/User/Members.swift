//
//  Members.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class Members: Mapable
{
    var users = [User]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataArrayUnwrapper(json) else
        {
            return false
        }
        
        for user in data
        {
            let temp = User()
            if temp.mapData(fromJson: user)
            {
                self.users.append(temp)
            }
        }
        
        return true
    }
}
