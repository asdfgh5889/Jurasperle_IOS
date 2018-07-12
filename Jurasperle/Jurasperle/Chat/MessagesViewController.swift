//
//  MessagesViewController.swift
//  Chat-Storyboard
//
//  Created by Dante Solorio on 10/11/16.
//  Copyright © 2016 iOS School Mexico. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var ownerTextField: UITextView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    let othersMessageCell = "OthersMessageCell"
    let ownerMessageCell = "OwnerMessageCell"
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.estimatedRowHeight = 50
        getExampleData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - General functions
    fileprivate func getExampleData(){
        let message1 = Message()
        message1.messageText = "Hi"
        message1.messageUserId = 1
        
        let message2 = Message()
        message2.messageText = "Hello"
        message2.messageUserId = 2
        
        let message3 = Message()
        message3.messageText = "How are you?"
        message3.messageUserId = 1
        
        let message4 = Message()
        message4.messageText = "Fine, how about you?"
        message4.messageUserId = 2
        
        messages += [message1, message2, message3, message4]
    }
    
    @objc func keyboardNotification(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = messagesTableView.dequeueReusableCell(withIdentifier: othersMessageCell, for: indexPath) as! OthersMessageCell
            let message = messages[indexPath.row]
            
            if message.messageUserId == 1
            {
                cell.othersMessageLabel.text = message.messageText
            }
            return cell
        case 1:
            let cell = messagesTableView.dequeueReusableCell(withIdentifier: ownerMessageCell, for: indexPath)as! OwnerMessageCell
            let message = messages[indexPath.row]
            if message.messageUserId == 2
            {
                cell.ownerMessageLabel.text = message.messageText
               
            }
            return cell
        default:
            let cell = messagesTableView.dequeueReusableCell(withIdentifier: ownerMessageCell)
            return cell!
            
        }
    }
    
   
    @IBAction func sendMessageAction(_ sender: Any){
        sendMessage()
    }
    
    func sendMessage(){
        ownerTextField.resignFirstResponder()
        if let text = ownerTextField.text{
            let messageToSend = Message()
            messageToSend.messageUserId = 2
            messageToSend.messageText = text
            messages.append(messageToSend)
            messagesTableView.reloadData()
            ownerTextField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }

}
