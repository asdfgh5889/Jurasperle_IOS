//
//  News.swift
//  Jurasperle
//
//  Created by Sherzod on 7/17/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class News: Mapable
{
    var id: Int?
    var title = LString()
    var content = LString()
    var publishData: String?
    var images = [String]()
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return false
        }
        var data = JurasperleAPI.dataUnwrapper(json) ?? jsonDic
        
        self.id = Utilities.ToInt(from: data["id"])
        self.title.mapData(fromJson: data["title"])
        self.content.mapData(fromJson: data["content"])
        self.publishData = Utilities.ToString(from: data["publish_date"])
        
        if let images = data["images"] as? [String]
        {
            for image in images
            {
                self.images.append("\(JurasperleAPI.baseURL)/\(image)")
            }
        }
        
        return true
    }
}
