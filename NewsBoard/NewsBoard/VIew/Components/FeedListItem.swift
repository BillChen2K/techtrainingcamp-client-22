//
//  feedListItem.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import SwiftUI

struct FeedListItem: View {
    var post: PostModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            switch post.type {
            case 1:
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(post.title!).frame(height: 50, alignment: .top).font(.system(size: 18, weight: .semibold, design: .default)).foregroundColor(.black)
                        HStack {
                            Text(post.author!).font(.caption).foregroundColor(.gray)
                            Text(post.publishTime!).font(.caption).foregroundColor(.secondary)
                        }.padding(.top, 6)
                    }.padding(.horizontal, 6)
                    Spacer()
                    Image(post.cover[0]).resizable().aspectRatio(contentMode: .fit).frame(width: 120, height: 70).cornerRadius(6).clipped()
                }
            case 2:
                HStack {

                    Image(post.cover[0]).resizable().aspectRatio(contentMode: .fit).frame(width: 120, height: 80).cornerRadius(6).clipped()
                    VStack(alignment: .leading, spacing: 0) {
                        Text(post.title!).frame(height: 50, alignment: .top).font(.system(size: 18, weight: .semibold, design: .default)).foregroundColor(.black)
                        HStack {
                            Text(post.author!).font(.caption).foregroundColor(.gray)
                            Text(post.publishTime!).font(.caption).foregroundColor(.secondary)
                        }.padding(.top, 6)
                    }.padding(.horizontal, 6)
                    
                }
            case 3:
                VStack(alignment: .leading, spacing: 0) {
                    Image(post.cover[0]).resizable().aspectRatio(contentMode: .fit).frame(height: 250) .cornerRadius(6).clipped().padding(.bottom, 12)
                    Text(post.title!).font(.system(size: 18, weight: .semibold, design: .default)).foregroundColor(.black)
                    HStack {
                        Text(post.author!).font(.caption).foregroundColor(.gray)
                        Text(post.publishTime!).font(.caption).foregroundColor(.secondary)
                    }.padding(.top, 6)
                }.padding(.horizontal, 6)
            case 4:
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(post.cover, id: \.self) {oneCover in
                                Image(oneCover).resizable().aspectRatio(contentMode: .fit).frame(height: 70) .cornerRadius(6).clipped().padding(.bottom, 12).padding(.trailing, 12)
                            }
                        }
                    }
                   
                    Text(post.title!).font(.system(size: 18, weight: .semibold, design: .default)).foregroundColor(.black)
                    HStack {
                        Text(post.author!).font(.caption).foregroundColor(.gray)
                        Text(post.publishTime!).font(.caption).foregroundColor(.secondary)
                    }.padding(.top, 6)
                }.padding(.horizontal, 6)
            default:
                VStack(alignment: .leading, spacing: 0) {
                    Text(post.title!).frame(height: 20).font(.system(size: 18, weight: .semibold, design: .default)).foregroundColor(.black)
                    HStack {
                        Text(post.author!).font(.caption).foregroundColor(.gray)
                        Text(post.publishTime!).font(.caption).foregroundColor(.secondary)
                    }.padding(.top, 6)
                }.padding(.horizontal, 6)
            }
            
            Rectangle().frame(height: 1).foregroundColor(Color.gray).padding(.top, 12).opacity(0.5)
        }.padding(.horizontal).padding(.top, 12)
        
    }
}

struct FeedListItem_Previews: PreviewProvider {
    static var previews: some View {
        FeedListItem(post: PostModel(id: "5696", title: "测试标题", author: "ByteDance", publishTime: "2020 年 11 月 22 日", type: 4, cover: ["tb09_3", "tb09_2", "tb09_1"]))
    }
}
