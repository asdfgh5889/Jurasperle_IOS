//
//  LoaderButton.swift
//  Experiments
//
//  Created by Sherzod on 6/27/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import UIKit

class LoaderButton: UIButton
{
    var loader: WinLoader!
    
    fileprivate var text: String?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setUpLoader()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setUpLoader()
    }
    
    func toggleLoader(_ isLoading: Bool)
    {
        isLoading ? self.startLoading() : self.stopLoading()
    }
    
    fileprivate func setUpLoader()
    {
        self.loader = WinLoader(.white)
        self.loader.isHidden = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.loader.translatesAutoresizingMaskIntoConstraints = false
        self.text = self.currentTitle
        
        self.addSubview(self.loader)
        
        self.addConstraints([
            self.loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    fileprivate func startLoading()
    {
        self.loader.isHidden = false
        self.loader.startAnimating()
        self.isEnabled = false
        self.text = self.currentTitle
        self.setTitle("", for: .normal)
    }
    
    fileprivate func stopLoading()
    {
        self.loader.isHidden = true
        self.loader.stopAnimating()
        self.isEnabled = true
        self.setTitle(self.text, for: .normal)
    }
}
