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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //Ha bezárjuk az alkalmazást és újra megnyitjuk de be voltunk jelentkezve
        if AuthService.instance.isLoggedin{
            AuthService.instance.findUserByEmail(completion: { (sucess) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
        
    }
    
    
    
    
}
