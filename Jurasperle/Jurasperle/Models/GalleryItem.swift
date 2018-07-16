//
//  Gallery.swift
//  Jurasperle
//
//  Created by Sherzod on 7/15/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

enum GalleryItemType
{
    case image
    case video
}

class GalleryItem: Mapable
{
    var id: Int?
    var coverURLStr: String?
    var type: GalleryItemType?
    var fullURLStr: String?
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return false
        }
        var data = JurasperleAPI.dataUnwrapper(json) ?? jsonDic
        
        self.id = Utilities.ToInt(from: data["id"])
        self.coverURLStr = Utilities.ToString(from: data["cover"])
        self.fullURLStr = Utilities.ToString(from: data["full_url"])
        self.type = Utilities.ToString(from: data["type"]) == "image" ? .image : .video
        
        return true
    }
}
