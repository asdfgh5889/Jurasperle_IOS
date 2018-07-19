//
//  NetworkProtocols.swift
//  Experiments
//
//  Created by Sherzod on 7/12/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import Foundation

protocol PostDataProtocol
{
    func getMethod() -> HTTPMethods
    func getPath() -> String
}

protocol HasQueryItems
{
    typealias QueryItems = [URLQueryItem]
    func getQueryItems() -> QueryItems?
}

protocol HasJsonBody
{
    typealias JsonBody = [String: Any]
    func getJsonBody() -> JsonBody?
}

protocol HasHeaderItems
{
    typealias HeaderItems = [String:String]
    func getHeaderItmes() -> HeaderItems?
}
