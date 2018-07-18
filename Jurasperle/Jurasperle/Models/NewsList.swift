//
//  NewsList.swift
//  Jurasperle
//
//  Created by Sherzod on 7/17/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class NewsList: Mapable
{
    var news = [News]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataArrayUnwrapper(json) else
        {
            return false
        }
        
        for newsJson in data
        {
            let temp = News()
            if temp.mapData(fromJson: newsJson)
            {
                self.news.append(temp)
            }
        }
        
        return true
    }
}
