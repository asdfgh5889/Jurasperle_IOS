//
//  EventsViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/20/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit
import Kingfisher
class EventsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventsTable: UITableView!
    var eventList = EventsList()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
        eventsTable.delegate = self
        eventsTable.dataSource = self
        self.title = "Мероприятия" 
    
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
                    self.eventsTable.reloadData()
                }
            }
         }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.events.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        let dates = eventList.events[indexPath.row].holdDates.joined(separator: ", ")
        cell.eventDate.text = dates
        let string1 = eventList.events[indexPath.row].description.text?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let eventContent = string1?.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
        cell.eventTitle.text = eventList.events[indexPath.row].title.text
        cell.eventDescription.text = eventContent
        cell.eventCover.kf.setImage(with: URL(string: eventList.events[indexPath.row].coverImageURLStr!))
        
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreEvent"
        {
            if let controller = segue.destination as? MoreEventsController, let moreInfoButton = sender as? UIButton
            {
                controller.events = eventList.events[moreInfoButton.tag]
            }
        }
    }
   
}
