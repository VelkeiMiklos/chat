//
//  ProfileVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 21..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfile()
    }
    //Actions
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutBtn(_ sender: Any) {
        UserService.instance.logoutUser()
        //Kell egy notification, hogy jelezzük azt, hogy kiléptünk
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupProfile(){
        profileImg.image = UIImage(named: UserService.instance.avatarName)
        profileImg.backgroundColor = UserService.instance.getUIColor(color: UserService.instance.avatarColor)
        emailLbl.text = UserService.instance.email
        userNameLbl.text = UserService.instance.name
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(){
    dismiss(animated: true, completion: nil)
    }
    
}
