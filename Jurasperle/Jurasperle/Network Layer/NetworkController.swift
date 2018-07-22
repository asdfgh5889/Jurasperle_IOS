//
//  NetworkController.swift
//  Experiments
//
//  Created by Sherzod on 7/12/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import UIKit

class NetworkController
{
    static func registerDeviceToken(_ postData: RegisterDeviceToken, _ completion: @escaping (GeneralResponse?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    
    static func getEventsList(_ postData: GetEventsListPostData, _ completion: @escaping (EventsList?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func writeToUser(_ postData: WriteToUserPostData, _ completion: @escaping (ConversationRoomInfo?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func logout(_ postData: LogoutPostData, _ completion: @escaping (GeneralResponse?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getContacts(_ postData: GetContactsPostData, _ completion: @escaping (ContactList?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getGallery(_ postData: GalleryPostData, _ completion: @escaping (Gallery?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getAuthorization(_ postData: AuthorizationPostData, _ completion: @escaping (Authorization?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func changeUserProfileData(_ postData: ChangeUserProfilePostData, _ completion: @escaping (User?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getPartners(_ postData: PartnersPostData, _ completion: @escaping (PartnerList?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getNews(_ postData: NewsPostData, _ completion: @escaping (NewsList?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func sendMessage(_ postData: MessagePostData, _ completion: @escaping (ConversationRoomInfo?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getConversationRoom(_ postData: ConversationRoomPostData, _ completion: @escaping (ConversationRoom?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getConversationRoomInfo(_ postData: ConversationRoomInfoPostData, _ completion: @escaping (ConversationRoomInfo?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
    static func getConversationList(_ postData: ConversationsPostData, _ completion: @escaping (ConversationList?) -> Void)
    {
        let request = RequestController.generateRequest(postData)!
        fetchRawData(request, completion)
    }
    
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
    
    static var reAuth: Bool = true
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
                
                if reAuth
                {
                    UserGlobalData.loadUserData({}, nil)
                    reAuth = false
                }
                
                completion(nil)
                return
            }
            reAuth = true
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
            //print(String(data: data, encoding: .utf8))
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
