//
//  MoreNewsViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/19/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class MoreNewsViewController: UIViewController {
    
    @IBOutlet weak var newsBody: UITextView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    var news: News!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsDate.text = news.publishData
        newsTitle.text = news.title.ruString
        let string1 = news.content.ruString?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let newsContent = string1?.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        newsBody.text = newsContent
    }
}
