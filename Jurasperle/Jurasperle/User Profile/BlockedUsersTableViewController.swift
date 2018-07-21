//
//  BlockedUsersTableViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class BlockedUsersTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource
{
    var contactList = ContactList()
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        setUpContacts()
//    }
    
    func setUpContacts()
    {
        
        let pd = GetContactsPostData()
        NetworkController.getContacts(pd){ (contactList: ContactList?) in
            DispatchQueue.main.sync {
              if let contactList = contactList
                {
                    self.contactList = contactList
                    
                    
                }
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactList.contacts.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "blokedUsers")as! BlockedUsersCell
        cell.userName.text = contactList.contacts[indexPath.row].name.ruString
        
        return cell
    }

}
