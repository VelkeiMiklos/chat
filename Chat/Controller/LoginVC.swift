//
//  LoginVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 22..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //Actions
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let password = passwordTxt.text , passwordTxt.text != "" else {return}
        //login művelet email és password alapján
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success{
                print("login was success")
                //Ha belépett, akkor az adatok lekérdezése email alapján
                AuthService.instance.findUserByEmail(completion: { (sucess) in
                    print("find user:", UserService.instance.email, AuthService.instance.token)
                    //Notification kiadása
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                    //activityIndicator leállítása
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    //ablak bezárása
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }

    @IBAction func createAccountBtn(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    //Functions
    func setupView(){
        activityIndicator.isHidden = true
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholder])
    }
}
