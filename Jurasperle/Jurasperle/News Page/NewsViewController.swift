//
//  NewsViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/13/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var newsTable: UITableView!
    var newsList = NewsList()
    var newsGalleryControllers = [NewsGalleryController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTable.delegate = self
        newsTable.dataSource = self
        setUpNewsData()
        self.title = "Новости"
    }
    
    
    func setUpNewsData()
    {
         ViewLoader.showLoaderView(for: self.view)
        let pd = NewsPostData()
        NetworkController.getNews(pd){ (newsList: NewsList?) in
            DispatchQueue.main.sync {
                ViewLoader.hideLoaderView(for: self.view)
                if let newsList = newsList
                {
                    self.newsList = newsList
                    
                    for news in newsList.news
                    {
                        self.newsGalleryControllers.append(NewsGalleryController(news.images)) 
                    }
                    
                    self.newsTable.reloadData()
                }
            }
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsList.news.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        cell.newsDate.text = newsList.news[indexPath.row].publishData
        cell.newsTitle.text = newsList.news[indexPath.row].title.text
        let string1 = newsList.news[indexPath.row].content.text?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let newsContent = string1?.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        cell.newsBody.text = newsContent
        cell.moreButton.tag = indexPath.row
        
        cell.newsImages.dataSource = self.newsGalleryControllers[indexPath.row]
        cell.newsImages.delegate = self.newsGalleryControllers[indexPath.row]
        cell.newsImages.reloadData()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreNews"
        {
            if let controller = segue.destination as? MoreNewsViewController, let moreInfoButton = sender as? UIButton
            {
                controller.news = newsList.news[moreInfoButton.tag]
            }
        }
    }
    
    
}
