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
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "blokedUsers")as! BlockedUsersCell
        return cell
    }

}
