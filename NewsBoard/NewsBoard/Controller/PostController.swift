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
    
    /// Handle post with picture and titles in the same line.
    func postPostProcessor(in post: String) -> String {
        let processedPost = post.replacingOccurrences(of: "## ", with: "\n## ").replacingOccurrences(of: "![]", with: "\n![]")
            .replacingOccurrences(of: "\n    ", with: "\n")
//        print(processedPost)
        return processedPost
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
                    self.postContent = self.postPostProcessor(in: json["data"].string!)
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
