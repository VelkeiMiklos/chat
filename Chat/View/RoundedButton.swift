//
//  RoundedButton.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 22..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadious: CGFloat = 3.0{
        didSet{
            self.layer.cornerRadius = cornerRadious
        }
    }
    override func awakeFromNib() {
        setupView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView(){
        self.layer.cornerRadius = cornerRadious
    }
}
