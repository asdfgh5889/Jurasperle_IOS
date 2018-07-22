//
//  MoreNewsViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class MoreEventsController: UIViewController, UIWebViewDelegate
{
    @IBOutlet weak var eventWebView: UIWebView!
    var events: Event!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
               eventWebView.delegate = self
        
                let dates = events.holdDates.joined(separator: ", ")
                var content = "<div style=\"color: #E8AE37; padding: 8px\"> <p style=\"font-size: 17px\">\(dates)</p><p style=\"font-size: 22px\">\(events.title.text ?? "")</p></div>"
        
                var contentImages = "<div id='carousel'>"
                contentImages.append("<div><img class='object-fit_cover' src='\( events.coverImageURLStr ?? "")' /></div>")
        
                content.append("</div>")
                content.append(contentImages)
                content.append(events.description.text!)
                eventWebView.loadHTMLString(content, baseURL: nil)
        
    }
    
        func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
        {
            ViewLoader.showLoaderView(for: self.view)
            if navigationType == UIWebViewNavigationType.linkClicked {
                UIApplication.shared.openURL(request.url!)
                return false
            }
            return true
        }
    
        func webViewDidFinishLoad(_ webView: UIWebView)
        {
            ViewLoader.hideLoaderView(for: self.view)
            let css = "body { color : #fff } #carousel  { width: 100%; height: 200px; background-color: transparent;  padding-top: 40px;}  #carousel .object-fit_cover { object-fit: cover } #carousel img { height: 200px; background-color: transparent;}"
            let js = "var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);"
    
            webView.stringByEvaluatingJavaScript(from: js)
        }
    
    
}
