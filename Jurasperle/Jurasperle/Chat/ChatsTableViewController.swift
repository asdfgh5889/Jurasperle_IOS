//
//  ChatsTableViewController.swift
//  Chat-Storyboard
//
//  Created by Dante Solorio on 9/26/16.
//  Copyright © 2016 iOS School Mexico. All rights reserved.
//

import UIKit

class ChatsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableview: UITableView!
    
    var conversationList: ConversationList?
    
    let cellChat = "cellChat"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        ViewLoader.showLoaderView(for: self.view)
        NetworkController.getConversationList(ConversationsPostData()) {
            (conversationList: ConversationList?) in
            DispatchQueue.main.sync {
                ViewLoader.hideLoaderView(for: self.view)
                if let list = conversationList
                {
                    self.conversationList = list
                    self.tableview.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.conversationList?.conversationRooms.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellChat, for: indexPath) as! ChatTableViewCell
        cell.nameOfPerson.text = self.conversationList?.conversationRooms[indexPath.row].title
        cell.lastMessageLabel.text = self.conversationList?.conversationRooms[indexPath.row].lastMessageTime
        cell.timeLabel.text = self.conversationList?.conversationRooms[indexPath.row].lastMessageTime
        cell.profileImageView.kf.setImage(with: URL(string: self.conversationList?.conversationRooms[indexPath.row].logoURLStr ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "conversationRoom", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "conversationRoom"
        {
            if let controller = segue.destination as? MessagesViewController,
                let index = sender as? Int
            {
                controller.conversationId = self.conversationList?.conversationRooms[index].id ?? 0
            }
        }
    }
}
