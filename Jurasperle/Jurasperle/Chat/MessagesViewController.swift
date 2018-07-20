//
//  MessagesViewController.swift
//  Chat-Storyboard
//
//  Created by Dante Solorio on 10/11/16.
//  Copyright © 2016 iOS School Mexico. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var ownerTextField: UITextView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    let othersMessageCell = "OthersMessageCell"
    let ownerMessageCell = "OwnerMessageCell"
    
    var messages = [ChatMessage]()
    var conversationId: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.estimatedRowHeight = 50
        
        ViewLoader.showLoaderView(for: self.view)
        NetworkController.getConversationRoom(ConversationRoomPostData(self.conversationId))
        { (room: ConversationRoom?) in
            DispatchQueue.main.sync {
                ViewLoader.hideLoaderView(for: self.view)
                if let room = room
                {
                    self.messages.append(contentsOf: room.messages)
                    self.messagesTableView.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if self.messages[indexPath.row].senderUserId == UserGlobalData.auth.id
        {
            let cell = messagesTableView.dequeueReusableCell(withIdentifier: ownerMessageCell, for: indexPath)as! OwnerMessageCell
            cell.ownerMessageLabel.text = self.messages[indexPath.row].text
            return cell
        }
        else
        {
            let cell = messagesTableView.dequeueReusableCell(withIdentifier: othersMessageCell, for: indexPath) as! OthersMessageCell
            cell.othersMessageLabel.text = self.messages[indexPath.row].text
            return cell
        }
    }
    
    
    @IBAction func sendMessageAction(_ sender: Any)
    {
        sendMessage()
    }
    
    func sendMessage()
    {
        ownerTextField.resignFirstResponder()
        if let text = ownerTextField.text
        {
            NetworkController.sendMessage(MessagePostData(text, self.conversationId))
            { (room: ConversationRoomInfo?) in
            }
            
            let messageToSend = ChatMessage()
            messageToSend.senderUserId = UserGlobalData.auth.id
            messageToSend.text = text
            messages.append(messageToSend)
            messagesTableView.reloadData()
            ownerTextField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        sendMessage()
        return true
    }
    
    @objc func keyboardNotification(notification: NSNotification)
    {
        if let userInfo = notification.userInfo
        {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height
            {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            }
            else
            {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
}
