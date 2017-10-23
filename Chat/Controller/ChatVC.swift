//
//  ChatVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 21..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var mainLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedin{
            //Channelek lekérdezése
            onLoginGetMessages()
        }else{
            mainLbl.text = "Please Log In"
        }
    }
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        mainLbl.text = "#\(channelName)"
    }
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success{
                print("find all channellll")
            }
        }
    }
}
