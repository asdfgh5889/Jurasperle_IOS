//
//  Utilities.swift
//  Abad
//
//  Created by Sherzod on 8/23/17.
//  Copyright © 2017 Sherzod. All rights reserved.
//

import Foundation

class Utilities
{
    static func isPhonenumber(_ string: String) -> String?
    {
        let phoneRange = string.range(of: "^(\\+)(\\d{12})$|^(998)(\\d{9})$|^(\\d{9})$", options: .regularExpression)
        if phoneRange != nil
        {
            let phone = string.substring(with: phoneRange!)
            if phone.count == 13
            {
                return phone
            }
            else if phone.count == 12
            {
                return "+\(phone)"
            }
            else
            {
                return "+998\(phone)"
            }
        }
        
        return nil
    }
    
    static func isEmail(_ string: String) -> String?
    {
        if string.range(of: "\\S+@\\S+\\.\\S+", options: .regularExpression) != nil
        {
            return string
        }
        
        return nil
    }
    
    
    static func phonenumberFilter(_ phone: String?) -> String?
    {
        guard let phone = phone else
        {
            return nil
        }
        
        if phone.count == 13 || phone.count == 12 || phone.count == 9
        {
            let phoneRange = phone.range(of: "^(\\+)(\\d{12})$|^(998)(\\d{9})$|^(\\d{9})$", options: .regularExpression)
            if phoneRange != nil
            {
                let phone = phone.substring(with: phoneRange!)
                if phone.count == 13
                {
                    return phone
                }
                else if phone.count == 12
                {
                    return "+\(phone)"
                }
                else
                {
                    return "+998\(phone)"
                }
            }
        }
        
        return nil
    }
    
    static func ToInt(from data: Any?) -> Int?
    {
        guard let data = data else
        {
            return nil
        }
        
        if var strInt = data as? String
        {
            strInt = strInt.replacingOccurrences(of: " ", with: "")
            if let number = Int(strInt)
            {
                return number
            }
            else
            {
                return nil
            }
        }
        else if let number = data as? Int
        {
            return number
        }
        
        return nil
    }
    
    static func ToFloat(from data: Any?) -> Float?
    {
        guard let data = data else
        {
            return nil
        }
        
        if let strFloat = data as? String
        {
            if let number = Float(strFloat)
            {
                return number
            }
            else
            {
                return nil
            }
        }
        else if let number = data as? Float
        {
            return number
        }
        
        return nil
    }
    
    static func ToString(from data: Any?) -> String?
    {
        guard let strData = data, let str = strData as? String else
        {
            return nil
        }
        
        return str
    }
    
    static func ToBool(fron data: Any?) -> Bool?
    {
        if data == nil
        {
            return nil
        }
        
        if let val = Utilities.ToInt(from: data)
        {
            if val <= 0
            {
                return false
            }
            else
            {
                return true
            }
        }
        
        
        if let val = data as? Bool
        {
            return val
        }
        
        if let val = Utilities.ToString(from: data)
        {
            if(val == "true")
            {
                return true
            }
            else
            {
                return false
            }
        }
        
        return nil
    }
    
    static func JsonToDictionary(from data: Any?) -> [String: Any]?
    {
        return data as? [String: Any]
    }
    
    static func JsonToDisctionaryArray(from data: Any?) -> [[String: Any]]?
    {
        return data as? [[String: Any]]
    }
    
    static func JsonDataToDictionary(from data: Any?) -> [String: Any]?
    {
        if let data = data as? Data
        {
            return JsonDataToDictionary(from: data)
        }
        else
        {
            print("Recieved nil while converting json to dictionary")
            return nil
        }
    }
    
    static func JsonDataToDictionary(from data: Data?) -> [String: Any]?
    {
        do
        {
            if let data = data
            {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options:  JSONSerialization.ReadingOptions.allowFragments)
                if let jsonDic = jsonObject as? [String: Any]
                {
                    return jsonDic
                }
                else
                {
                    return nil
                }
            }
            else
            {
                print("Recieved nil while converting json to dictionary")
                return nil
            }
        }
        catch
        {
            print("Error while processing Json data")
            return nil
        }
    }
    
    static func JsonDataToArrDictionary(from data: Any?) -> [[String: Any]]?
    {
        if let data = data as? Data
        {
            return JsonDataToArrDictionary(from: data)
        }
        else
        {
            print("Recieved nil while converting json to dictionary")
            return nil
        }
    }
    
    static func JsonDataToArrDictionary(from data: Data?) -> [[String: Any]]?
    {
        do
        {
            if let data = data
            {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDic = jsonObject as? [[String: Any]]
                {
                    return jsonDic
                }
                else
                {
                    return nil
                }
            }
            else
            {
                print("Recieved nil while converting json to dictionary")
                return nil
            }
        }
        catch
        {
            print("Error while processing Json data")
            return nil
        }
    }
    static func JsonDataToAny(from data: Any?) -> Any?
    {
        if let data = data as? Data
        {
            return JsonDataToAny(from: data)
        }
        else
        {
            print("Recieved nil while converting json")
            return nil
        }
    }
    
    static func JsonDataToAny(from data: Data?) -> Any?
    {
        do
        {
            if let data = data
            {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                return jsonObject
            }
            else
            {
                print("Recieved nil while converting json")
                return nil
            }
        }
        catch
        {
            print("Error while processing Json data")
            return nil
        }
    }
    
    static func JsonStrToJsonObj(from data: String?) -> Any?
    {
        do
        {
            if let data = data?.data(using: .utf8)
            {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                return jsonObject
            }
            else
            {
                print("Recieved nil while converting json")
                return nil
            }
        }
        catch
        {
            print("Error while processing Json data")
            return nil
        }
    }
    
    static func JsonStrToJsonObj(from data: Any?) -> Any?
    {
        return JsonStrToJsonObj(from: ToString(from: data))
    }
    
    static func map()
    {
        
    }
    
    
    static func isAbadImageURL(_ url: String) -> Bool
    {
        if url.lowercased().range(of: "image") != nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    static func filterHTML(_ string: String?) -> String?
    {
        if let string = string
        {
            let ran = string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            return ran.replacingOccurrences(of: "(\\t+|\\s+|\\n+)", with: " ", options: .regularExpression, range: nil)
        }
        else
        {
            return nil
        }
    }
}
