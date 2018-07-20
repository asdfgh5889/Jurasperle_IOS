//
//  ViewLoader.swift
//  Experiments
//
//  Created by Sherzod on 6/28/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import UIKit

class ViewLoader
{
    fileprivate static var loaderViews = [Int:UIView]()
    fileprivate static var loaderViewSize: CGSize = CGSize(width: 65, height: 65)
    
    
    static func showLoaderView(for view: UIView)
    {
        if loaderViews[view.hashValue] == nil
        {
            let wrapper = UIView(frame: view.frame)
            wrapper.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            wrapper.isUserInteractionEnabled = true
            
            let loaderView = UIVisualEffectView(frame: CGRect(origin: view.center, size: loaderViewSize))
            loaderView.effect = UIBlurEffect(style: .extraLight)
            loaderView.translatesAutoresizingMaskIntoConstraints = false
            loaderView.clipsToBounds = true
            loaderView.layer.cornerRadius = 8
            loaderView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            
            let loader = WinLoader(UIColor.white)
            loader.translatesAutoresizingMaskIntoConstraints = false
            
            loaderView.contentView.addSubview(loader)
            wrapper.addSubview(loaderView)
            view.addSubview(wrapper)
            
            
            loaderView.contentView.addConstraints([
                loader.centerXAnchor.constraint(equalTo: loaderView.contentView.centerXAnchor),
                loader.centerYAnchor.constraint(equalTo: loaderView.contentView.centerYAnchor)
                ])
            
            wrapper.addConstraints([
                loaderView.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
                loaderView.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
                loaderView.heightAnchor.constraint(equalToConstant: loaderViewSize.height),
                loaderView.widthAnchor.constraint(equalToConstant: loaderViewSize.width)
                ])
            
            view.addConstraints([
                wrapper.topAnchor.constraint(equalTo: view.topAnchor),
                wrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                wrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                wrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            
            loaderViews[view.hashValue] = wrapper
            loader.startAnimating()
        }
    }
    
    static func hideLoaderView(for view: UIView)
    {
        if loaderViews[view.hashValue] != nil
        {
            loaderViews[view.hashValue]?.removeFromSuperview()
            loaderViews.removeValue(forKey: view.hashValue)
        }
    }
}
