//
//  RequestController.swift
//  Experiments
//
//  Created by Sherzod on 7/12/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import Foundation

enum HTTPMethods: String
{
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

class RequestController
{
    static var baseURL = "http://jurasperle.club"
    static var baseAPIPath = "/api"
    
    /**
     Generates URLRequest from data provided to use api
    
     - parameter postData:
     */
    static func generateRequest<T: PostDataProtocol>(_ postData: T) -> URLRequest?
    {
        guard let url = makeURL(postData.getPath(), postData) else
        {
            return nil
        }
        return makeURLRequest(url, postData)
    }
    
    static func makeURL<T: PostDataProtocol>(_ method: String , _ postData: T) -> URL?
    {
        guard var urlComponents = URLComponents(string: baseURL) else
        {
            return nil
        }
        
        urlComponents.path = prepareStrURL("\(baseAPIPath)\(method)/")
        
        if let pdWithQuery = postData as? HasQueryItems
        {
            if let items = pdWithQuery.getQueryItems()
            {
                urlComponents.queryItems = [URLQueryItem]()
                for item in items
                {
                    urlComponents.queryItems!.append(item)
                }
            }
        }
        
        return urlComponents.url
    }
    
    static func makeURLRequest<T: PostDataProtocol>(_ url: URL, _ postData: T) -> URLRequest
    {
        var request = URLRequest(url: url)
        request.httpMethod = postData.getMethod().rawValue
        
        if let pdWithHeader = postData as? HasHeaderItems
        {
            if let header = pdWithHeader.getHeaderItmes()
            {
                for (key, value) in header
                {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        
        if let pdWithJsonBody = postData as? HasJsonBody
        {
            if(JSONSerialization.isValidJSONObject(pdWithJsonBody.getJsonBody() as Any))
            {
                do
                {
                    request.httpBody = try JSONSerialization.data(withJSONObject: pdWithJsonBody.getJsonBody()!)
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                catch
                {
                    print(error.localizedDescription)
                }
            }
            else
            {
                print("Invalid Json Data!")
            }
        }
        
        return request
    }
    
    static func prepareStrURL(_ strUrl: String) -> String
    {
        var count = 0
        var prepared = ""
        for strChar in strUrl
        {
            if strChar == "/"
            {
                count += 1
            }
            else
            {
                count = 0
            }
            
            if count != 2
            {
                prepared.append(strChar)
            }
            else
            {
                count = 0
            }
        }
        
        return prepared
    }
}
