//
//  UserGlobalData.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

enum Language
{
    case en
    case ru
}

class UserGlobalData
{
    static var language: Language = .ru
    static var auth: Authorization!
}
