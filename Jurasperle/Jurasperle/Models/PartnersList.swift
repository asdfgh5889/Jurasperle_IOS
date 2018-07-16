//
//  PartnersList.swift
//  Jurasperle
//
//  Created by Sherzod on 7/14/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class PartnersList: Mapable
{
    var partners = [Partner]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataArrayUnwrapper(json) else
        {
            return false
        }
        
        for user in data
        {
            let temp = Partner()
            if temp.mapData(fromJson: user)
            {
                self.partners.append(temp)
            }
        }
        
        return true
    }
}
