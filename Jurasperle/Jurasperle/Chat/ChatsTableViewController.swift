//
//  ChatsTableViewController.swift
//  Chat-Storyboard
//
//  Created by Dante Solorio on 9/26/16.
//  Copyright © 2016 iOS School Mexico. All rights reserved.
//

import UIKit

class ChatsTableViewController: UITableViewController {
    
    let cellChat = "cellChat"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellChat, for: indexPath) as! ChatTableViewCell
        cell.nameOfPerson.text = "Person \(indexPath.row)"
        cell.lastMessageLabel.text = "This is a example text number \(indexPath.row)"
        cell.timeLabel.text = "12:00"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

   

}
