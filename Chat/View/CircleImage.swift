//
//  CircleImage.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 21..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }
    func setupView()
    {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}
