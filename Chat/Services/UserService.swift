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
    
    func getUIColor(color: String)-> UIColor{
        //"avatarColor": "[0.0862745098039216, 0.796078431372549, 0.105882352941176, 1]",
   
        //scanner mit vizsgáljon
        let scanner = Scanner(string: color)
        //mit hadjon ki a karaktersorozatból
        let skipped = CharacterSet(charactersIn: "[], ")
        scanner.charactersToBeSkipped = skipped
        
        //változók
        var r, g, b, a: NSString?
        
        //scan
        scanner.scanUpToCharacters(from: skipped, into: &r)
        scanner.scanUpToCharacters(from: skipped, into: &g)
        scanner.scanUpToCharacters(from: skipped, into: &b)
        scanner.scanUpToCharacters(from: skipped, into: &a)
        
        //default változó ha valami még sem sikerül
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        //Floatra konvertálás
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        //a kivágott változó létrehozása
        let cuttedUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return cuttedUIColor
    }
    
    func logoutUser(){
        //Logout meghívásakor minden eltárolt adatot törölni kell
        self.id = ""
        self.avatarColor = ""
        self.avatarName  = ""
        self.email = ""
        self.name = ""
        AuthService.instance.isLoggedin = false
        AuthService.instance.token = ""
        AuthService.instance.userEmail = ""
        MessageService.instance.clearChannels()
    }
}
