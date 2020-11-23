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
    
    @Published var currentUser: UserModel?
    @Published var loginStatus: LoginStatus = .loggedOut {
        didSet {
            print("Login status switched: \(self.loginStatus)")
        }
    }
    
    /// Try to load username from credentials.
    init() {
        // Load saved user
        if let data = UserDefaults.standard.data(forKey: "SavedUser") {
            do {
                let decoder = JSONDecoder()
                self.loginStatus = .cached
                currentUser = try decoder.decode(UserModel.self, from: data)
            } catch {
                print("Unable to decode saved user. (\(error))")
            }
        }
    }
    
    /// Save username and credential info to UserDefaults.
    func saveUser() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(currentUser)
            UserDefaults.standard.setValue(data, forKey: "SavedUser")
        }
        catch {
            print("Unable to save user. (\(error))")

        }
    }
   
    func performLogIn(username: String, password: String, remember: Bool = true, completion: @escaping (_ result: ResponseStatus) -> Void){
        
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
                self.currentUser!.logInTime = Date()
                self.loginStatus = .loggedIn
                if remember {
                    self.saveUser()
                }
                completion(.success)
            case .failure(let error):
                print(error)
                completion(.networkError)
            }
        }
    }
    
    func performlogOut(isOutdated: Bool = false) {
        self.currentUser = nil
        UserDefaults.standard.removeObject(forKey: "SavedUser")
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
