//
//  self.swift
//  Abad
//
//  Created by Sherzod on 7/11/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import UIKit

class RoundButton: UIButton
{
    init()
    {
        super.init(frame: CGRect(x: 140, y: 140, width: 60, height: 60))
        self.layer.cornerRadius = self.layer.frame.size.width/2
        self.clipsToBounds = true
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    convenience init(in view: UIView)
    {
        self.init()
        view.addSubview(self)
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            self.widthAnchor.constraint(equalToConstant: 60),
            self.heightAnchor.constraint(equalToConstant: 60)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func hide()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.alpha = 0
        })
    }
    
    func show()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(rotationAngle: 0)
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.alpha = 1
        })
    }
}

class CallButton: RoundButton
{
    override init()
    {
        super.init()
        self.backgroundColor = UIColor.rgb(red: 147, green: 203, blue: 114)
        self.setImage(UIImage(named:"phone-receiver.png"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class FilterButton: RoundButton
{
    override init()
    {
        super.init()
        self.backgroundColor = MainColors.mainColor
        self.setImage(UIImage(named:"filter-icon"), for: .normal)
        self.imageView?.tintColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
