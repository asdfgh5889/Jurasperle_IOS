//
//  ViewController.swift
//  Jurasperle
//
//  Created by Sherzod on 6/30/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var MembersView: UIView!
    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var partnersView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var chatView: UIView!
    var color:UIColor = UIColor(red: 205/255, green: 133/255, blue: 63/255, alpha: 1)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setViewStyles()
    }
    
    func setViewStyles()
    {
        galleryView.layer.addBorder(edge: .left, color: color, thickness: 1)
        partnersView.layer.addBorder(edge: .top, color:color , thickness: 1)
        newsView.layer.addBorder(edge: .left, color: color, thickness: 1)
        newsView.layer.addBorder(edge: .top, color:color , thickness: 1)
        profileView.layer.addBorder(edge: .top, color: color, thickness: 1)
        chatView.layer.addBorder(edge: .left, color: color, thickness: 1)
        chatView.layer.addBorder(edge: .top, color: color, thickness: 1)
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
    }
    
    
    @IBAction func logoutButtonAction(_ sender: Any)
    {
        let alert = UIAlertController(title: "", message: "Выйти из аккаунта?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: {{ (action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            }}())
        let delete = UIAlertAction(title: "Да", style: .destructive, handler: {
        { (action: UIAlertAction) in
            UserGlobalData.logout()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginView")
            UIApplication.shared.keyWindow?.rootViewController = initialViewController
            }}())
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func goToChatView(_ sender: Any)
    {
        
    }
}




// Extantions
extension CALayer
{    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer();
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width+30, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height + 30)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}

