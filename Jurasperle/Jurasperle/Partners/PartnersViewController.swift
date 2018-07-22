//
//  PartnersViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/2/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

class PartnersViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var partnersCollection: UICollectionView!
    var partnerlist = PartnerList()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpPartnerData()
        self.title = "Партнеры"
    }
    
    func setUpPartnerData()
    {
        ViewLoader.showLoaderView(for: self.view)
       
        let pd = PartnersPostData()
        NetworkController.getPartners(pd){ (partnerlist: PartnerList?) in
            DispatchQueue.main.sync {
                 ViewLoader.hideLoaderView(for: self.view)
                if let partnerlist = partnerlist
                {
                    self.partnerlist = partnerlist
                    self.partnersCollection.reloadData()
                    
                }
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if partnerlist.partners.count != 0
        {
            return partnerlist.partners.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "partnerCell", for: indexPath)as! PartnerCell
        cell.backgrounImage.kf.setImage(with: URL(string: partnerlist.partners[indexPath.row].logoURLStr!))
        cell.phoneNumber.text = partnerlist.partners[indexPath.row].phonenumber
        cell.address.text = partnerlist.partners[indexPath.row].address.text
        cell.webPageLink.text = partnerlist.partners[indexPath.row].website
        cell.titleLabel.text = partnerlist.partners[indexPath.row].title.text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = URL(string: partnerlist.partners[indexPath.row].website!)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
        
    }
}
