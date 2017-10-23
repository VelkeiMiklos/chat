//
//  ChannelCell.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 23..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelLbl: UILabel!
    
    func configureCell(channel: Channel){
        let title = channel.name ?? ""
        channelLbl.text = "#\(title)"
    }

}
