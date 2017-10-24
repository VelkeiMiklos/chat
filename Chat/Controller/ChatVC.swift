//
//  ChatVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 21..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    //Variables
    var isTyping = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        sendBtn.isHidden = true
        //becsült sor hossz
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Keyboard felmenjen amikor gépel
        view.bindToKeyboard()
        //Keyboard eltüntetése
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleKeyboardTap))
        view.addGestureRecognizer(tap)
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        //Ha bezárjuk az alkalmazást és újra megnyitjuk de be voltunk jelentkezve
        if AuthService.instance.isLoggedin{
            AuthService.instance.findUserByEmail(completion: { (sucess) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        //új message megjelenjen
        if AuthService.instance.isLoggedin{
            SocketService.instance.getChatMessage(completion: { (success) in
                if success{
                    self.tableView.reloadData()
                    
                    if MessageService.instance.messages.count > 0{
                        //ha több mint 0 akkor mindig legalúlra kerüljön
                        let endIndex = IndexPath(row: MessageService.instance.messages.count - 1 , section: 0)
                        self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                    }
                }
            })
        }
        
    }
    @objc func handleKeyboardTap(){
        view.endEditing(true)
    }
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedin{
            //Channelek lekérdezése
            onLoginGetMessages()
        }else{
            mainLbl.text = "Please Log In"
            //kilépéskor eltünjön a message
            tableView.reloadData()
        }
    }
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        mainLbl.text = "#\(channelName)"
        getMessages()
    }
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success{
                print("find all channel")
                // Ha be vagyunk lépve és legalább egy van akkor az első legyen a default
                if MessageService.instance.channels.count > 0
                {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.mainLbl.text = "No channels yet!"
                }
            }
        }
    }
    func getMessages(){
        guard let chnannelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessageForChannel(channelId: chnannelId) { (success) in
            if success{
                print("find messages")
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedin{
            
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTxt.text else {return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserService.instance.id, channelId: channelId, completion: { (success) in
                print("message was sent")
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
            })
        }
    }
    //event edigint changed
    @IBAction func messageTxtEditing(_ sender: Any) {
        
        if messageTxt.text == ""{
            isTyping = false
            sendBtn.isHidden = true
        }else{
            if isTyping == false{
                sendBtn.isHidden = false
            }
            isTyping = true
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MESSAGE_CELL, for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.congigureCell(message: message)
            return cell
        }else{
            return MessageCell()
        }
    }
    
}
