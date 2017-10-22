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
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Actions
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
    }

    @IBAction func createAccountBtn(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
}
