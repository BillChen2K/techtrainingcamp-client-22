//
//  UserController.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserController: ObservableObject{
    
    //    required init(from decoder: Decoder) throws {
    //
    //    }
    //
    //    func encode(to encoder: Encoder) throws {
    //
    //    }
    
    @Published var currentUser: UserModel?
    @Published var loginStatus: LoginStatus = .loggedOut
    
    func performLogIn(username: String, password: String, completion: @escaping (_ result: ResponseStatus) -> Void){
        
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]
        
        AF.request(Config.API + "/login", method: .post, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.currentUser = UserModel(username: username)
                self.currentUser!.token = json["token"].string!
                self.loginStatus = .loggedIn
                completion(.success)
            case .failure(let error):
                print(error)
                completion(.networkError)
            }
        }
    }
    
    func performlogOut(isOutdated: Bool = false) {
        self.currentUser = nil
        if isOutdated {
            self.loginStatus = .outdated
        }
        else {
            self.loginStatus = .loggedOut
        }
    }
}

enum LoginStatus {
    case loggedOut
    case loggedIn
    case cached
    case outdated
}
