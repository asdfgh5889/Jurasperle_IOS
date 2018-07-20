//
//  GeneralResponse.swift
//  Jurasperle
//
//  Created by Sherzod on 7/20/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class GeneralResponse: Mapable
{
    var errorCode: JurasErrorCode = .noError
    
    required init() {}
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return false
        }
        
        if let ok = Utilities.ToString(from:  jsonDic["data"])
        {
            self.errorCode = ok == "ok" ? .noError : .error
        }
        
        return true
    }
}
