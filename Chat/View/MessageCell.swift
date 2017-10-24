//
//  MessageCell.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 24..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userAvatarImg: CircleImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func congigureCell(message: Messages){
        messageLbl.text = message.messageBody
       // timeStampLbl.text = message.timeStamp
        userNameLbl.text = message.userName
        userAvatarImg.image = UIImage(named: message.userAvatar)
        userAvatarImg.backgroundColor = UserService.instance.getUIColor(color: message.userAvatarColor)
        
        //2017-10-24T19:11:26.590Z

        guard var isoDate = message.timeStamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate{
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }
    }
}
