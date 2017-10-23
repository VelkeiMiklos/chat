//
//  MessageService.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 23..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService{
    
    //Variables
    static let instance = MessageService()
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    //Functions
    func findAllChannels(completion: @escaping CompletionHandler){
        let header = [
            "Authorization":"Bearer \(AuthService.instance.token)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        Alamofire.request(URL_FIND_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil{
                
                guard let data = response.data else { return }
                if let json = JSON(data: data).array{
                    for item in json{
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        let channel = Channel(id: id, name: name, description: description)
                        self.channels.append(channel)
                    }
                }
                //Jelezzük, hogy betöltöttük a channelek-et
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels(){
        channels.removeAll()
    }
   
}
