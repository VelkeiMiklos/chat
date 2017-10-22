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
    }
    //Unwind Segue
     @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    
    @IBAction func loginBtn(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
}
