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
    var members = [User]()
    var blockedUsers = [Int]()
    
    func setUpContacts(_ tableView: UITableView)
    {
        NetworkController.getMemebers(MembersPostData())
        { (members: Members?) in
            if let members = members
            {
                DispatchQueue.main.sync {
                self.members = members.users
                tableView.reloadData()
                    NetworkController.getBlockedUsers(GetBlockedUsers(), { (users: BlockedUsers?) in
                        if let users = users
                        {
                            DispatchQueue.main.sync {
                                self.blockedUsers.append(contentsOf: users.userIds)
                                tableView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    
    func blockUser(at row: Int)
    {
        if self.blockedUsers.contains(self.members[row].userId ?? 0)
        {
            self.blockedUsers.remove(at: self.blockedUsers.index(of: self.members[row].userId ?? 0)!)
        }
        else
        {
            self.blockedUsers.append(self.members[row].userId ?? 0)
        }
    }
    
    func saveBlockedUsers()
    {
        NetworkController.setBlockedUsers(SetBlockedUsers(self.blockedUsers))
        { (response: GeneralResponse?) in
            //print(response?.errorCode)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "blokedUsers") as! BlockedUsersCell
        cell.userName.text = members[indexPath.row].name.text
        cell.blockUser.isOn = (self.blockedUsers.filter({ $0 == (members[indexPath.row].userId ?? 0) }).count != 0)
        cell.blockUser.tag = indexPath.row
        return cell
    }

}
