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
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    let messageCellId = "messageCellId"
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.estimatedRowHeight = 44
        
        getExampleData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        messageTextField.delegate = self
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
    
    // MARK: - Table delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: messageCellId, for: indexPath) as! MessageTableViewCell
        
        let message = messages[indexPath.row]
        
        // Message text
        cell.messageLabel.text = message.messageText
        // Message user
        if message.messageUserId == 1{
            cell.messageLabel.textAlignment = .right
            cell.backgroundColor = .blue
            cell.messageLabel.textColor = .white
        }
        return cell
    }
    
    // MARK: - Actions
    @IBAction func sendMessageAction(_ sender: Any){
        sendMessage()
    }
    
    func sendMessage(){
        messageTextField.resignFirstResponder()
        
        if let text = messageTextField.text{
            let messageToSend = Message()
            messageToSend.messageUserId = 1
            messageToSend.messageText = text
            messages.append(messageToSend)
            messagesTableView.reloadData()
            messageTextField.text = ""
        }
        
    }
    
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }

   

}
