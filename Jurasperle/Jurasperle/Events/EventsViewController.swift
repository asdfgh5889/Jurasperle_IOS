//
//  EventsViewController.swift
//  Jurasperle
//
//  Created by Dragon on 7/20/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet weak var eventBody: UIWebView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
       eventBody.loadHTMLString("hjfdbvhjdsvbhdsbvjhdbvkjhfvblhdbjkdfjhdfvbkjdbvjhdbjhdbdhbfdfsjhdfbjhdfbjfdkvdfjvhfbdvjsdfbkjsdfkjsdvbkjdsvbdfjkvbdfjs", baseURL: nil)
        eventDate.text = "61546565163"
        eventTitle.text = "jsdvhgdvkjdhl kasvkh k adsvkguka kausdg kuadgfkuasdgfasudf uadsf gagsodiusadgaiusy"
    }

  func setUpEvents()
  {
    
    
   }

}
