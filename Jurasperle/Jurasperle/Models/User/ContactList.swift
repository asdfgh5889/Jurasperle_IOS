//
//  ContactList.swift
//  Jurasperle
//
//  Created by Sherzod on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class ContactList: Mapable
{
    var contacts = [Contact]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataUnwrapper(json, "contacts") else
        {
            return false
        }
        
        for (id, name) in data
        {
            let temp = Contact()
            if let id = Utilities.ToInt(from: id)
            {
                temp.userId = id
                temp.name.mapData(fromJson: name)
                self.contacts.append(temp)
            }
        }
        
        return true
    }
}
