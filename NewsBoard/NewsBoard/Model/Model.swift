//
//  Model.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import Foundation

class UserModel: Identifiable {
    var username: String?
    var token: String?
    
    
    internal init(username: String? = "") {
        self.username = username
    }
}
