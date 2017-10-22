//
//  ProfileVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 21..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //Actions
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutBtn(_ sender: Any) {
    }
}
