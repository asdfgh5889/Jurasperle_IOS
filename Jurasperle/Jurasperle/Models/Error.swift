//
//  Error.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

enum JurasErrorCode: Int
{
    case noError = 0
    case error = 1
}

class JurasError: Mapable
{
    var errorCode: Int = 0
    var message: String?
    
    required init()
    {
        
    }
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else {
            return false
        }
        
        self.errorCode = Utilities.ToInt(from: jsonDic["error"]) ?? 0
        self.message = Utilities.ToString(from: jsonDic["message"])
        
        return true
    }
}
