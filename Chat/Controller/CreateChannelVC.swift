//
//  CreateChannelVC.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 22..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class CreateChannelVC: UIViewController {

    //Outlets
    @IBOutlet weak var channelNameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createChannelBtn(_ sender: Any) {
    }

    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
