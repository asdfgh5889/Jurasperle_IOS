//
//  PartnersViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/2/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class PartnersViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "partnerCell", for: indexPath)
       
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 

}
