//
//  PostModel.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import Foundation

class PostModel: Identifiable {
    internal init(id: String? = nil, title: String? = nil, author: String? = nil, publishTime: String? = nil, type: Int = 0, cover: [String] = []) {
        self.id = id
        self.title = title
        self.author = author
        self.publishTime = publishTime
        self.type = type
        self.cover = cover
    }
    
    var id: String?
    var title: String?
    var author: String?
    var publishTime: String?
    var type: Int = 0
    var cover: [String] = []

}
