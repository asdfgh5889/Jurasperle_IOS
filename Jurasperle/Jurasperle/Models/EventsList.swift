//
//  EventsList.swift
//  Jurasperle
//
//  Created by Sherzod on 7/21/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class EventsList: Mapable
{
    var events = [Event]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataArrayUnwrapper(json) else
        {
            return false
        }
        
        for eventJson in data
        {
            let temp = Event()
            if temp.mapData(fromJson: eventJson)
            {
                self.events.append(temp)
            }
        }
        return true
    }
}
