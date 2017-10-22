//
//  UserService.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 22..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
class UserService{
    
    static let instance = UserService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName  = avatarName
        self.email = email
        self.name = name
    }
    
    //Avatar választásnál el kell menteni
    func setUserAvatar(avatarName: String){
        self.avatarName = avatarName
    }
    
}
