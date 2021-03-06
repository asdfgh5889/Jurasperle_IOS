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
    var conversationPd: ConversationRoomPostData!
    var conversarionRoomInfo: ConversationRoomInfo?
    var receiverUserId: Int?
    
    fileprivate var timer: Timer?
    fileprivate var listernerIsLoading = false
    fileprivate var isLoading: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.estimatedRowHeight = 50
        self.messagesTableView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.title = self.conversarionRoomInfo?.title
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(touch)
        
        ViewLoader.showLoaderView(for: self.view)
        
        if self.receiverUserId == nil
        {
            self.conversationPd = ConversationRoomPostData(self.conversationId)
            self.loadMessages()
        }
        else
        {
            NetworkController.writeToUser(WriteToUserPostData(self.receiverUserId!)) { (_ room: ConversationRoomInfo?) in
                DispatchQueue.main.sync {
                    if let room = room
                    {
                        self.conversationId = room.id ?? 0
                        self.conversationPd = ConversationRoomPostData(self.conversationId)
                        self.loadMessages()
                    }
                    else
                    {
                        ViewLoader.hideLoaderView(for: self.view)
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
             self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.checkForNewMessages), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    @objc func checkForNewMessages()
    {
        if self.messages.count > 0 && !self.listernerIsLoading
        {
            self.listernerIsLoading = true
            NetworkController.getConversationRoom(ConversationRoomPostData(self.conversationId))
            { (room: ConversationRoom?) in
                print("request")
                if let room = room, let lastMessageId = self.messages.first!.id
                {
                    let newMessages = room.messages.filter({ message in
                        message.id! > lastMessageId
                    })
                    
                    DispatchQueue.main.sync {
                        self.putNewMessages(newMessages)
                        self.listernerIsLoading = false
                    }
                }
                else
                {
                    self.listernerIsLoading = false
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
            cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            return cell
        }
        else
        {
            let cell = messagesTableView.dequeueReusableCell(withIdentifier: othersMessageCell, for: indexPath) as! OthersMessageCell
            cell.othersMessageLabel.text = self.messages[indexPath.row].text
            cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetHeight = scrollView.contentSize.height - scrollView.frame.height
        if scrollView.contentOffset.y > offsetHeight && offsetHeight >= 0 && !isLoading
        {
            self.isLoading = true
            loadMessages()
        }
    }
    
    func loadMessages()
    {
        NetworkController.getConversationRoom(self.conversationPd)
        { (room: ConversationRoom?) in
            DispatchQueue.main.sync {
                if let room = room
                {
                    ViewLoader.hideLoaderView(for: self.view)
                    self.conversationPd.pageMetadata = room.pageMetadata
                    
                    self.messagesTableView.beginUpdates()
                    
                    var indexPaths = [IndexPath]()
                    
                    for index in self.messages.count ..< self.messages.count + room.messages.count
                    {
                        indexPaths.append(IndexPath(row: index, section: 0))
                    }
                    self.messages.append(contentsOf: room.messages)
                    self.messagesTableView.insertRows(at: indexPaths, with: .none)
                    self.messagesTableView.endUpdates()
                    
                    if room.pageMetadata?.currentPage ?? 0 <= room.pageMetadata?.lastpage ?? -1
                    {
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    @IBAction func sendMessageAction(_ sender: Any)
    {
        sendMessage()
    }
    
    func sendMessage()
    {
        ownerTextField.resignFirstResponder()
        if let text = ownerTextField.text, text.count > 0
        {
            NetworkController.sendMessage(MessagePostData(text, self.conversationId))
            { (room: ConversationRoomInfo?) in
            }
            putMessagesWith(id: UserGlobalData.auth.id, messages: [text])
        }
        ownerTextField.text = ""
    }
    
    func putMessagesWith(id: Int?, messages texts: [String?])
    {
        var messages = [ChatMessage]()
        for message in texts
        {
            let messageToPut = ChatMessage()
            messageToPut.id = (self.messages.first!.id ?? 0) + 1
            messageToPut.senderUserId = id
            messageToPut.text = message
            messages.append(messageToPut)
        }
        
        putNewMessages(messages)
    }
    
    func putNewMessages(_ messages: [ChatMessage])
    {
        var indexpaths = [IndexPath]()
        
        for index in 0..<messages.count
        {
            indexpaths.append(IndexPath(row: index, section: 0))
        }
        
        self.messages.insert(contentsOf: messages, at: 0)
        self.messagesTableView.beginUpdates()
        self.messagesTableView.insertRows(at: indexpaths, with: .top)
        self.messagesTableView.endUpdates()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        sendMessage()
        return true
    }
    
    @objc func dismissKeyboard()
    {
        self.ownerTextField.resignFirstResponder()
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
