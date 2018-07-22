//
//  MembersViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/1/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit
import Kingfisher

class MembersViewController: UIViewController,UITableViewDataSource, UITableViewDelegate
{
    
    
    @IBOutlet weak var membersTable: UITableView!
    var member = Members()
    var userIndex: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpmemberData()
        self.title = "Члены клуба"
    }
    
    func setUpmemberData()
    {
        ViewLoader.showLoaderView(for: self.view)
        let pd = MembersPostData()
        NetworkController.getMemebers(pd){ (member: Members?) in
            DispatchQueue.main.sync {
                 ViewLoader.hideLoaderView(for: self.view)
                if let member = member
                {
                    self.member = member
                    self.membersTable.reloadData()
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return member.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as! MembersCell
        cell.memberNameLable.text = member.users[indexPath.row].name.text
        cell.memberImageCell.kf.setImage(with: URL(string: member.users[indexPath.row].photoURLStr!))
        cell.moreInfo.tag = indexPath.row
        cell.sendMessage.tag = member.users[indexPath.row].userId ?? 0
        userIndex = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func goToChat(_ sender: UIButton)
    {
        if sender.tag != UserGlobalData.auth.id!
        {
            self.performSegue(withIdentifier: "chat", sender: sender.tag)
        }
        else
        {
            self.performSegue(withIdentifier: "conversationRoomList", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "moreInfo"
        {
            if let controller = segue.destination as? MembersBiographyController, let moreInfoButton = sender as? UIButton
            {
                controller.user = member.users[moreInfoButton.tag]
                
            }
        }
        if segue.identifier == "chat"
        {
            if let controller = segue.destination as? MessagesViewController,
            let convId = sender as? Int
            {
                controller.receiverUserId = convId
            }
        }
    }
    
}
