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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpmemberData()
        
    }
    
    func setUpmemberData()
    {
        let pd = MembersPostData()
        NetworkController.getMemebers(pd){ (member: Members?) in
            DispatchQueue.main.sync {
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
        cell.memberNameLable.text = member.users[indexPath.row].name.ruString
        cell.memberImageCell.kf.setImage(with: URL(string: member.users[indexPath.row].photoURLStr!))
        cell.moreInfo.tag = indexPath.row
        userIndex = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo"
        {
            if let controller = segue.destination as? MembersBiographyController, let moreInfoButton = sender as? UIButton
            {
                controller.user = member.users[moreInfoButton.tag]
                
            }
        }
    }
    
}
