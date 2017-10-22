//
//  CreateAccountVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 22..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var userImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //Variables
    var avatar_Name:String = "profileDefault"
    var avatar_Color:String = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //Ha van ki lett választva az avatar, akkor azt kell beállítani a képnek
        if UserService.instance.avatarName != ""{
            self.userImg.image = UIImage(named: "\(UserService.instance.avatarName)" )
            avatar_Name = UserService.instance.avatarName
        }
    }
    
    //Actions
    @IBAction func chooseAvatarBtn(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR, sender: nil)
    }
    @IBAction func closeBtn(_ sender: Any) {
        //Vissza a chanell-re
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    @IBAction func generateBacgroundColorBtn(_ sender: Any) {
        //Random generate color
        let r = CGFloat(arc4random_uniform(255)) / 255//0-255 és el kell osztani a szín miatt
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatar_Color = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2){
            self.userImg.backgroundColor = self.bgColor
        }
    }

    @IBAction func createAccountBtn(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return }
        guard let name = userNameTxt.text, userNameTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email , password: password) { (success) in
            if success{
                print("registered user!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (sucess) in
                    if sucess{
                        print("user logged in", AuthService.instance.token)
                        
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatar_Name, avatarColor: self.avatar_Color, completion: { (sucess) in
                            print(success)
                            if sucess{
                                print("Add user: ", UserService.instance.name, UserService.instance.avatarName)
                                self.activityIndicator.isHidden = true
                                self.activityIndicator.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                //Notification: felhasználó létrehozva
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    func setupView(){
        
        activityIndicator.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholder])
        
        //Tap Gesture a keyboard eltüntetéséhez
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.closeKeyBoard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func closeKeyBoard(){
        view.endEditing(true)
    }
}
