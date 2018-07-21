//
//  WriteToUserPostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/21/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class WriteToUserPostData: PostDataProtocol, HasHeaderItems
{
    var userId: Int
    
    init(_ userId: Int)
    {
        self.userId = userId
    }
    
    func getPath() -> String
    {
        return "\(JurasperleAPI.writeTo)/\(self.userId)"
    }
    
    func getMethod() -> HTTPMethods
    {
        return .get
    }
    
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        return header
    }
}
