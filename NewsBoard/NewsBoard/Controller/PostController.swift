//
//  PostController.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostController: ObservableObject {
    
    @Published var postContent: String?
    
    func localPictureTransformer(raw: String) -> String {
        let cssPath = Bundle.main.path(forResource: "markdown", ofType: "css")
        return "hi"
    }
    
    func getPostContent(token: String, id: String, completion: @escaping (_ result: ResponseStatus) -> Void) {
        
        let parameters: [String: String] = [
            "markdown": "true",
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(Config.API + "/article/\(id)", method: .get, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["message"].string! == "success" {
                    self.postContent = json["data"].string!
                    print(self.postContent!)
                    completion(.success)
                }
                else if json["code"].string! == "credentials_bad_format"{
                    completion(.tokenInvalid)
                }
                else {
                    completion(.networkError)
                }
            case .failure(let error):
                print(error)
                if error.responseCode == 401 {
                    completion(.tokenInvalid)
                }
                completion(.networkError)
            }
        }
    }
}

enum ResponseStatus {
    case success
    case tokenInvalid
    case networkError
    case serverError
}
