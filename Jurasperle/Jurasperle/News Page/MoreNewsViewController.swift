//
//  MoreNewsViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class MoreNewsViewController: UIViewController, UIWebViewDelegate
{
    @IBOutlet weak var newsBody: UIWebView!
    var news: News!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        newsBody.delegate = self
        var content = "<div style=\"color: #E8AE37; padding: 8px\"> <p style=\"font-size: 17px\">\(news.publishData ?? "")</p><p style=\"font-size: 22px\">\(news.title.ruString ?? "")</p></div>"
        content.append(news.content.ruString!)
        
        if news.images.count > 0
        {
            var contentImages = "<div id='carousel'>"
            for image in news.images
            {
                contentImages.append("<div class='slide'><img class='object-fit_cover' src='\(image)' /></div>")
            }
            contentImages.append("</div>")
            content.append(contentImages)
        }
        
        newsBody.loadHTMLString(content, baseURL: nil)
     }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.openURL(request.url!)
            return false
        }
        return true
    }

    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        let css = "body { color : #fff } #carousel  { width: 100%; height: 200px; background-color: transparent; overflow: scroll; -webkit-overflow-scrolling: touch; white-space:nowrap; padding-top: 40px;}  #carousel .slide { display: inline-block; } #carousel .object-fit_cover { object-fit: cover } #carousel img { height: 200px; background-color: transparent;}"
        let js = "var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);"
        
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
//    {
//
//        let css = "body { color : #000000 }"
//
//        let js = "var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);"
//
//        webView.evaluateJavaScript(js, completionHandler: nil)
//    }
}
