//
//  APIPaths.swift
//  Experiments
//
//  Created by Sherzod on 7/12/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import Foundation

class JurasperleAPI
{
    
    static func dataUnwrapper(_ json: Any) -> [String: Any]?
    {
        return dataUnwrapper(json, "data")
    }
    
    static func dataArrayUnwrapper(_ json: Any) -> [Any]?
    {
        return dataArrayUnwrapper(json, "data")
    }
    
    static func dataUnwrapper(_ json: Any, _ withKey: String) -> [String: Any]?
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return nil
        }
        
        if let data = jsonDic[withKey] as? [String: Any]
        {
            return data
        }
        else
        {
            return nil
        }
    }
    
    static func dataArrayUnwrapper(_ json: Any, _ withKey: String) -> [Any]?
    {
        guard let jsonDic = json as? [String: Any] else
        {
            return nil
        }
        
        if let data = jsonDic[withKey] as? [Any]
        {
            return data
        }
        else
        {
            return nil
        }
    }
    
    static let baseURL = "http://jurasperle.club"
    static let login: String = "/login"
    static let members: String = "/members"
    static let gallery: String = "/gallery"
    static let mainAlbum: String = "/main_alboom"
    static let news: String = "/news"
    static let partner: String = "/partner"
    static let user: String = "/user"
    static let profile: String = "/profile"
    static let avatar: String = "/avatar"
    static let blocked: String = "/blocked"
    static let password: String = "/password"
    static let events: String = "/events"
    static let eventsGo: String = "/events/go"
    static let conversations: String = "/conversations/"
    static let messages: String = "/messages/"
    static let messagesImage: String = "/messages/image/"
    static let writeTo: String = "/write_to/"
    static let birthdays: String = "/birthdays/"
    static let notifications: String = "/notifications/"
    static let albooms: String = "/albooms/"
    static let photo: String = "/photo/"
    static let deviceToken: String = "/device_token"
    static let contacts: String = "/contacts"
    static let logout: String = "/logout"
}
