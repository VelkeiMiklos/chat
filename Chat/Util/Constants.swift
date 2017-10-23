//
//  Constants.swift
//  Chat
//
//  Created by Velkei Miklós on 2017. 10. 22..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"
let TO_AVATAR = "toAvatar"

//Cells
let AVATAR_CELL = "avatarCell"
let CHANNEL_CELL = "channelCell"
//URL
let URL_BASE = "https://chatalk.herokuapp.com/v1/"
let URL_REGISTER = "\(URL_BASE)account/register"
let URL_LOGIN = "\(URL_BASE)account/login"
let URL_ADD_USER = "\(URL_BASE)user/add"
let URL_FIND_USER_BY_EMAIL = "\(URL_BASE)/user/byEmail/"
let URL_FIND_ALL_CHANNELS = "\(URL_BASE)channel"
//User defaults key

let LOGGED_IN_KEY = "isLoggedIn"
let TOKEN_KEY   = "token"
let USER_EMAIL_KEY = "userEmail"

//Typealias
typealias CompletionHandler = (_ Success: Bool)-> ()

//Header
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

//Color
let purplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

//Notification
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("notifChannelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("notifChannelSelected")
