//
//  Gallery.swift
//  Jurasperle
//
//  Created by Sherzod on 7/15/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class Gallery: Mapable
{
    var items = [GalleryItem]()
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let data = JurasperleAPI.dataArrayUnwrapper(json) else
        {
            return false
        }
        
        for item in data
        {
            let temp = GalleryItem()
            if temp.mapData(fromJson: item)
            {
                self.items.append(temp)
            }
        }
        
        return true
    }
}
