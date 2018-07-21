//
//  EventsViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/20/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit
import Kingfisher
class EventsViewController: UITableViewController,UIWebViewDelegate {
    
    var eventList = EventsList()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
         self.tableView.backgroundView = UIImageView(image: UIImage(named: "non_main_bg")!)
    
    }
    
    func setUpEvents()
    {
        let pd = GetEventsListPostData()
        ViewLoader.showLoaderView(for: self.view)
        NetworkController.getEventsList(pd){ (eventList: EventsList?) in
            DispatchQueue.main.sync {
                ViewLoader.hideLoaderView(for: self.view)
                if let eventList = eventList
                {
                    self.eventList = eventList
                    self.tableView.reloadData()
                }
            }
         }
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        let dates = eventList.events[indexPath.row].holdDates.joined(separator: ", ")
       
        var content = "<div style=\"color: #E8AE37; padding: 8px\"> <p style=\"font-size: 17px\">\(dates)</p><p style=\"font-size: 22px\">\(eventList.events[indexPath.row].title.text ?? "")</p></div>"
        
        var contentImages = "<div id='carousel'>"
        contentImages.append("<div><img class='object-fit_cover' src='\( eventList.events[indexPath.row].coverImageURLStr ?? "")' /></div>")
        
        contentImages.append("<div>")
        content.append(contentImages)
        content.append(eventList.events[indexPath.row].description.text!)
        
        cell.eventWebView.loadHTMLString(content, baseURL: nil)
       
        return cell
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
        let css = "body { color : #fff } #carousel  { width: 100%; height: 200px; background-color: transparent; overflow: scroll; -webkit-overflow-scrolling: touch; white-space:nowrap; padding-top: 40px;}  #carousel .slide { display: inline-block; } #carousel .object-fit_cover { object-fit: cover } #carousel img { height: 200px; background-color: transparent;}"
        let js = "var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);"
        
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
    
   
}
