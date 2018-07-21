//
//  PageMetadata.swift
//  Jurasperle
//
//  Created by Sherzod on 7/21/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class PageMetadata: Mapable
{

    var first: String?
    var last: String?
    var prev: String?
    var next: String?
    var currentPage: Int?
    var offset: Int?
    var lastpage: Int?
    var path: String?
    var perPage: Int?
    var to: Int?
    var total: Int?
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return false
        }
        
        //Map links
        if let linksJson = jsonDic["links"] as? [String: Any]
        {
            self.first = Utilities.ToString(from: linksJson["first"])
            self.last = Utilities.ToString(from: linksJson["last"])
            self.prev = Utilities.ToString(from: linksJson["prev"])
            self.next = Utilities.ToString(from: linksJson["next"])
        }
        
        //Map meta
        if let metaJson = jsonDic["meta"] as? [String: Any]
        {
            self.currentPage = Utilities.ToInt(from: metaJson["current_page"])
            self.offset = Utilities.ToInt(from: metaJson["from"])
            self.lastpage = Utilities.ToInt(from: metaJson["last_page"])
            self.path = Utilities.ToString(from: metaJson["path"])
            self.perPage = Utilities.ToInt(from: metaJson["per_page"])
            self.to = Utilities.ToInt(from: metaJson["to"])
            self.total = Utilities.ToInt(from: metaJson["total"])
        }
        
        return true
    }
}
