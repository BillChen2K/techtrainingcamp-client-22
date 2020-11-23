//
//  Model.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import Foundation

class UserModel: Identifiable, Codable {
    
    var username: String?
    var token: String?
    var logInTime: Date?
    
    internal init(username: String? = "") {
        self.username = username
        self.logInTime = Date()
    }
}
