//
//  UserController.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import Foundation
import Alamofire

class UserController: ObservableObject {
    var currentUser: UserModel?
    var token: String?
    
    func login(username: String, password: String){
        token = ""
    }
}
