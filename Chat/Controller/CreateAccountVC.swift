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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //Variables
    let avatar_Name:String = "dark5"
    let avatar_Color:String = "[0.5, 0.5, 0.5, 1]"
    //Actions
    @IBAction func chooseAvatarBtn(_ sender: Any) {
    }
    @IBAction func closeBtn(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    @IBAction func generateBacgroundColorBtn(_ sender: Any) {
    }
    
    @IBAction func createAccountBtn(_ sender: Any) {
        
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
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                            }
                        })
                   }
                })
            }
        }
    }
}
