//
//  GetEventsList.swift
//  Jurasperle
//
//  Created by Sherzod on 7/21/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class GetEventsListPostData: PostDataProtocol, HasHeaderItems
{
    func getPath() -> String
    {
        return JurasperleAPI.events
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
