//
//  ChannelVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 21..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var profileImg: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        //Figyelő létrehozása a notificationre
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpUserInfo()
    }
    
    //Unwind Segue
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    //Functions
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
    
    @objc func userDataDidChange(_ notif: Notification){
        setUpUserInfo()
    }
    
    func setUpUserInfo(){
        if AuthService.instance.isLoggedin{
            profileImg.image = UIImage(named: "\(UserService.instance.avatarName)")
            loginBtn.setTitle(UserService.instance.name, for: .normal)
            profileImg.backgroundColor = UserService.instance.getUIColor(color: UserService.instance.avatarColor)
        }else{
            loginBtn.setTitle("Login", for: .normal)
            profileImg.image = UIImage(named: "menuProfileIcon")
            profileImg.backgroundColor = UIColor.clear
        }
    }
    
}
