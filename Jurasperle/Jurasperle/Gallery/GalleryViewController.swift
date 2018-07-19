//
//  GalleryViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/2/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

class GalleryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var galleryCollection: UICollectionView!
    var gallery = Gallery()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGallery()
        
    }
    
    func setUpGallery()
    {
        ViewLoader.showLoaderView(for: self.view)
        let pd = GalleryPostData()
        NetworkController.getGallery(pd){  (gallery: Gallery?) in
            DispatchQueue.main.sync {
                 ViewLoader.hideLoaderView(for: self.view)
                if let gallery = gallery
                {
                    self.gallery = gallery
                    self.galleryCollection.reloadData()
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath)as! GalleryCell
         if gallery.items[indexPath.row].type == .image
         {
           cell.playButton.isHidden = true
         }
        else
         {
            cell.playButton.isHidden = false
         }
        cell.galleryImage.kf.setImage(with: URL(string: gallery.items[indexPath.row].coverURLStr!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if gallery.items[indexPath.row].type == .video
        {
            let url = URL(string: gallery.items[indexPath.row].fullURLStr!)
            let vc = SFSafariViewController(url: url!)
            present(vc, animated: true, completion: nil)
            
        }
    }
    
}
