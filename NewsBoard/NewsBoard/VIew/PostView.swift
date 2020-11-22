//
//  PostView.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import SwiftUI

struct PostView: View {
    var post: PostModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                }
                Text(post.title!).font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack {
                    Text(post.author!).font(.caption).foregroundColor(.gray)
                    Text(post.publishTime!).font(.caption).foregroundColor(.secondary)
                }.padding(.top, 6)
                
            }.padding()
           
        }.navigationTitle("")
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: PostModel(id: "5696", title: "测试标题", author: "ByteDance", publishTime: "2020 年 11 月 22 日", type: 4, cover: ["tb09_3", "tb09_2", "tb09_1"]))
    }
}
