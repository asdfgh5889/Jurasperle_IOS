//
//  ChatViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/2/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath)as! ChatCollectionViewCell
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.height/2
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
