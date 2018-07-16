//
//  GalleryPostData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/15/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

class GalleryPostData: PostDataProtocol, HasHeaderItems
{
    func getHeaderItmes() -> HeaderItems?
    {
        var header = [String: String]()
        header["Authorization"] = "Bearer \(UserGlobalData.auth.apiToken ?? "")"
        print(header)
        return header
    }
    
    func getMethod() -> HTTPMethods
    {
        return .get
    }
    
    func getPath() -> String
    {
        return JurasperleAPI.gallery
    }
}
