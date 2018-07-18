//
//  Protocols.swift
//  Jurasperle
//
//  Created by Sherzod on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

protocol Mapable
{
    init()
    @discardableResult func mapData(fromJson json: Any) -> Bool
}
