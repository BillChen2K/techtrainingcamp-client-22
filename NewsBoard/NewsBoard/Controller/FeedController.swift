//
//  FeedController.swift
//  newsboard
//
//  Created by Bill Chen on 2020/11/22.
//

import Foundation
import SwiftyJSON
import SwiftUI

class FeedController: ObservableObject {
    
    @Published var feedList : [PostModel] = []
    @Published var isLoading = false
    
    init() {
        //        let _ = self.loadFeedList()
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        let _ = self.loadFeedList()
        //        }
    }
    
    func loadFeedList() -> [PostModel] {
        var feedList: [PostModel] = []
        guard let metaDataPath = Bundle.main.path(forResource: "metadata", ofType: "json") else {
            // If the property list doesn't exist, we'll throw an error for now.
            fatalError("Unable to find metadata.json")
        }
        let jsonData = NSData(contentsOfFile: metaDataPath)
        do {
            let metaData = try JSON(data: jsonData! as Data)
            for (_, one):(String, JSON) in metaData {
                let onePost = PostModel(id: one["id"].string!, title: one["title"].string!, author: one["author"].string!, publishTime: one["publishTime"].string!, type: one["type"].int!)
                switch one["type"].int! {
                case 1...3:
                    onePost.cover = [one["cover"].string!.hasPrefix("http") ?
                                        one["cover"].string! :
                                        one["cover"].string!.replacingOccurrences(of: ".jpg", with: "").replacingOccurrences(of: ".png", with: "")]
                case 4:
                    for (_, oneCoverJson): (String, JSON) in one["covers"] {
                        let oneCover = oneCoverJson.string!
                        onePost.cover.append(oneCover.hasPrefix("http") ?
                                                oneCover :
                                                oneCover.replacingOccurrences(of: ".jpg", with: "").replacingOccurrences(of: ".png", with: ""))
                    }
                default:
                    onePost.cover = []
                }
                withAnimation {
                    feedList.append(onePost)
                }
            }
            self.feedList = feedList
            return feedList
            
        }
        catch {
            fatalError("Fail to parse json file.")
        }
    }
}
