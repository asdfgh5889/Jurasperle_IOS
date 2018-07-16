//
//  NetworkController.swift
//  Experiments
//
//  Created by Sherzod on 7/12/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import UIKit

class NetworkControllerExample: UIViewController
{
    @IBAction func test()
    {
        //NetworkController.test()
    }
}

class NetworkController
{
    static func getMemebers(_ postData: MembersPostData, _ completion: @escaping (Members?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getUserProfile(_ postData: UserProfilePostData, _ completion: @escaping (User?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func login(_ postData: LoginPostData, _ completion: @escaping (Authorization?) -> Void)
    {
        let request = RequestController.generateRequest(postData)
        fetchRawData(request!, completion)
    }
    
    static func fetchRawData<T: Mapable>(_ request: URLRequest, _ completion: @escaping (T?) -> Void)
    {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request)
            { (data, response, error) -> Void in
                
                if (error != nil)
                {
                    print("Something went wrong while fetching data")
                    return
                }
                
                guard let mappedObj = processRawData(data: data!, mapTo: T()) else
                {
                    print("Error While Processing raw data")
                    completion(nil)
                    return
                }
                
                completion(mappedObj)
            }
            task.resume()
    }
    
    static func fetchRawData<T>(_ request: URLRequest, _ completion: @escaping ([T]?) -> Void) where T: Mapable
    {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request)
            { (data, response, error) -> Void in
                if (error != nil)
                {
                    print("Something went wrong while fetching data")
                    return
                }
                
                guard let mappedObjArray = processRawData(data: data!, mapTo: [T]()) else
                {
                    print("Error While Processing raw data")
                    completion(nil)
                    return
                }
                
                completion(mappedObjArray)
            }
            task.resume()
    }
    
    static func processRawData<T>(data: Data, mapTo: T) -> T? where T: Mapable
    {
        do
        {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            return mapTo.mapData(fromJson: jsonObject) ? mapTo : nil
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func processRawData<T>(data: Data, mapTo: [T]) -> [T]? where T: Mapable
    {
        do
        {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            var rawArray: [Any]?
            if let jsonArray = jsonObject as? [Any]
            {
                rawArray = jsonArray
            }
            
            guard let jsonArray = rawArray else
            {
                print("received non array of: \(type(of: T()))")
                return nil
            }
            
            var mappedObjects = [T]()
            
            for rawObjectJson in jsonArray
            {
                let temp = T()
                if temp.mapData(fromJson: rawObjectJson)
                {
                    mappedObjects.append(temp)
                }
            }
            
            return mappedObjects
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
    }
}
