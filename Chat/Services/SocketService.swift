//
//  SocketService.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 23..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import SocketIO

class SocketService: NSObject{
    static let instance = SocketService()
    
    override init(){
        super.init()
    }

    //Meg van a socket
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: URL_BASE)!)
    
    //Amikor lounch kell egy establish Appdelegate.swift
    func establishConnection(){
        socket.connect()
    }
    //Amikor bezárjuk disconnectálni kell Appdelegate.swift
    func closeConnection(){
        socket.disconnect()
    }
    //Listens for a new chat message
    //client.on('newChannel', function(name, description) {
    //Create channel
    //let newChannel = new Channel({
    //name: name,
    //description: description,
    //});
    
    //Save it to database
    //newChannel.save(function(err, channel){
    //Send message to those connected in the room
    //console.log('new channel created');
    //io.emit("channelCreated", channel.name, channel.description, channel.id);
    //});
    //});

    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        //linstening egy eventre dataArray jön vissza
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDescription = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else{return}
            
            let newChannel = Channel(id: channelId, name: channelName, description: channelDescription)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
        
    }
    //New Message
   // client.on('newMessage', function(messageBody, userId, channelId, userName, userAvatar, userAvatarColor) {
    //Create message
    
    //console.log(messageBody);
    
   // let newMessage = new Message({
   // messageBody: messageBody,
    //userId: userId,
    //channelId: channelId,
    //userName: userName,
    //userAvatar: userAvatar,
    //userAvatarColor: userAvatarColor
    //});
    //Save it to database
    //newMessage.save(function(err, msg){
    //Send message to those connected in the room
    //console.log('new message sent');
    
   // io.emit("messageCreated",  msg.messageBody, msg.userId, msg.channelId, msg.userName, msg.userAvatar, msg.userAvatarColor, msg.id, msg.timeStamp);
    //});
    func addMessage(messageBody: String, userId: String, channelId:String, completion: @escaping CompletionHandler ){
        let user = UserService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    func getChatMessage(completion: @escaping CompletionHandler){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let message = dataArray[0] as? String else {return}
            guard let userId = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedin{
                      let newMessage = Messages(id: id, messageBody: message, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            }else{
                completion(false)
            }

        }
    }
}
