//
//  Contact.swift
//  Jurasperle
//
//  Created by Sherzod on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation


class Contact: Mapable
{
    var userId: Int?
    var name = LString()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = json as? [String:Any] else
        {
            return false
        }
        
        for (id, name) in data
        {
            self.userId = Utilities.ToInt(from: id)
            self.name.mapData(fromJson: name)
        }
        
        return true
    }
}
