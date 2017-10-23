//
//  ChannelVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 21..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var profileImg: CircleImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        tableView.delegate = self
        tableView.dataSource = self
        
        //Figyelő létrehozása a  used data change notificationre
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        //Figyelő a channel loaded-re
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        // Itt figyeljük ha igazzal tér vissza akkor új channel lett létrehozva és frissíteni kell a táblát
        SocketService.instance.getChannel { (success) in
            if success{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpUserInfo()
    }
    
    //Unwind Segue
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    //Actions
    @IBAction func loginBtn(_ sender: Any) {
        //Ha be van lépve akkor a Profile-t hívja meg, amúgy meg a TO_LOGIN
        if AuthService.instance.isLoggedin{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func addChannelBtn(_ sender: Any) {
        if AuthService.instance.isLoggedin{
            let addChannel = CreateChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        setUpUserInfo()
    }
    @objc func channelsLoaded(_ notif: Notification){
        self.tableView.reloadData()
    }
    
    func setUpUserInfo(){
        if AuthService.instance.isLoggedin{
            profileImg.image = UIImage(named: "\(UserService.instance.avatarName)")
            loginBtn.setTitle(UserService.instance.name, for: .normal)
            profileImg.backgroundColor = UserService.instance.getUIColor(color: UserService.instance.avatarColor)
        }else{
            // Ha nem vagyunk belépve akkor mindent vissza kell állítani
            loginBtn.setTitle("Login", for: .normal)
            profileImg.image = UIImage(named: "menuProfileIcon")
            profileImg.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
    //TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CHANNEL_CELL, for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else{
            return ChannelCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //Elmenteni a kiválasztott channelt
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        //Channel választva küldeni a notification-t
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        //vissza állítani a nézetet
        self.revealViewController().revealToggle(true)
    }
}
