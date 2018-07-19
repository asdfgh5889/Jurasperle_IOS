//
//  NewsCell.swift
//  Jurasperle
//
//  Created by Dragon on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var newsImages: UICollectionView!
    @IBOutlet weak var newsBody: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 6
        
    }
}

class NewsGalleryController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource
{
    var images: [String]!
    convenience init(_ images: [String])
    {
        self.init()
        self.images = images
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsImage", for: indexPath) as! NewsImageCell
        cell.newsGalleryImage.kf.setImage(with: URL(string: images[indexPath.row]))
        return cell
        
    }
    
    
}
