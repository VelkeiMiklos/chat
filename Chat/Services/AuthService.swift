//
//  AuthService.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 22..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import Alamofire

class AuthService{
    
    static let instance = AuthService()
    
    //User defaults
    let defaults = UserDefaults.standard
    //el kell tárolni, hogy be van jelentkezve?
    var isLoggedin : Bool{
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    //el kell tárolni a tokent
    var token: String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    //el kell tárolni a user email-t
    var userEmail:String{
        get{
            return defaults.value(forKey: USER_EMAIL_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL_KEY)
        }
    }
    
    //Felhasználó regisztrálása
    func registerUser(email: String, password: String,  completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        //Body
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        print(URL_REGISTER)
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    //Felhasználó beléptetése
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        //Body
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        print(URL_LOGIN)
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil{
                
                if let json = response.result.value as? Dictionary<String, Any>
                {
                    if let email = json["user"] as? String{
                        self.userEmail = email
                    }
                    if let token = json["token"] as? String{
                        self.token = token
                    }
                }
                self.isLoggedin = true
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }

    }
}
