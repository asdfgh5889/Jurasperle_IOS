//
//  MembersViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/1/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController,UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell")as! MembersCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
   
   override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

  

}
