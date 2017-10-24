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
    var messages = [Messages]()
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
    
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler){
        let header = [
            "Authorization":"Bearer \(AuthService.instance.token)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        Alamofire.request("\(URL_FIND_MESSAGE_BY_CHANNEL)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil{
                self.clearMessages()
                guard let data = response.data else {return}
                if let json = JSON(data: data).array{
                    for item in json{
                        let id = item["_id"].stringValue
                        let messageBody = item["messageBody"].stringValue
                        let userId = item["userId"].stringValue
                        let channelId = item["channelId"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        let message = Messages(id: id, messageBody: messageBody, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                        self.messages.append(message)
                        
                    }
                    print(self.messages)
                    completion(true)
                    
                }
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    func clearMessages(){
        messages.removeAll()
    }
    func clearChannels(){
        channels.removeAll()
    }
}
