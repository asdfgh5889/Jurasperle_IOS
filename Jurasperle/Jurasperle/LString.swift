//
//  LString.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class LString: Mapable
{
    var enString: String?
    var ruString: String?
    
    required init() {}
    
    convenience init(_ enString: String?, _ ruString: String?)
    {
        self.init()
        self.enString = enString
        self.ruString = ruString
    }
    
    @discardableResult func mapData(fromJson json: Any) -> Bool
    {
        guard let jsonDic = json as? [String: Any] else {
            return false
        }
        
        self.enString = Utilities.ToString(from: jsonDic["en"])
        self.ruString = Utilities.ToString(from: jsonDic["ru"])
        
        return true
    }
    
    static func +=(left: inout String?, right: LString)
    {
        left = UserGlobalData.language == Language.en ? right.enString: right.ruString
    }
}
