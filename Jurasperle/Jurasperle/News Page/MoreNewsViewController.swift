//
//  MoreNewsViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class MoreNewsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var newsBody: UIWebView!
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    var news: News!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsBody.delegate = self
        newsDate.text = news.publishData
        newsTitle.text = news.title.ruString
        newsBody.loadHTMLString(news.content.ruString!, baseURL: nil)
     }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.openURL(request.url!)
            return false
        }
        return true
    }
}
