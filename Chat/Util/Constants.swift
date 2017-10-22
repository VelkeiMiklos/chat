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

//URL
let URL_BASE = "https://chatalk.herokuapp.com/v1"
let URL_REGISTER = "\(URL_BASE)/account/register"
let URL_LOGIN = "\(URL_BASE)/account/login"
let URL_ADD_USER = "\(URL_BASE)/user/add"
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
