//
//  PostView.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import SwiftUI

struct PostView: View {
    var post: PostModel = PostModel(title: "A Post")
    var body: some View {
        Text(post.title!)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
