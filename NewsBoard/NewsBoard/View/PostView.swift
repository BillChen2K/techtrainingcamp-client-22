//
//  PostView.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/22.
//

import SwiftUI

struct PostView: View {
    @State var isLoading = true
    @State var isLogInPushed: Bool
    
    @ObservedObject var postController = PostController()
    @ObservedObject var userController: UserController
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var post: PostModel
    var body: some View {
        
        //            Button(action: { presentationMode.wrappedValue.dismiss() }) {
        //                HStack {
        //                    ZStack {
        //                        Rectangle().frame(width: 32, height: 32).foregroundColor(.primary).cornerRadius(20)
        //                        Image(systemName: "chevron.left").foregroundColor(.white)
        //                    }
        //                    .padding(.leading)
        //                    Text("返回").foregroundColor(.primary)
        //                    Spacer()
        //                }
        //            }
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(post.title!).font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack {
                    Text(post.author!).font(.caption).foregroundColor(.gray)
                    Text(post.publishTime!).font(.caption).foregroundColor(.secondary)
                }.padding(.top, 6)
            }.padding(.horizontal)
            if isLoading {
                HStack {
                    Spacer()
                    LoadingIndicator(strokeColor: .primary, size: .Inline).padding()
                    Spacer()
                }.padding()
                .transition(.opacity)
                .animation(.easeInOut)
            }
            else{
                MarkdownDisplayer(content: postController.postContent ?? "").padding(.top)
//                HStack {
//                    Spacer()
//                    Text("•").font(.title3).foregroundColor(.gray).padding().padding()
//                    Spacer()
//                }
            }
            NavigationLink(
                destination: LogInView(userController: userController), isActive: $isLogInPushed) {
            }
            Spacer()
        }
        .onAppear() {
            if [LoginStatus.loggedIn, LoginStatus.cached].contains(userController.loginStatus) {
                self.postController.getPostContent(token: userController.currentUser!.token!, id: post.id!) { result in
                    if result == .success {
                        withAnimation {
                            self.isLoading.toggle()
                        }
                    }
                    else if result == .tokenInvalid {
                        self.userController.performlogOut(isOutdated: true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.isLogInPushed = true
                        }
                    }
                }
            }
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                self.isLogInPushed = true
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        //        .navigationBarHidden(true)
        
    }
}

struct PostView_Previews: PreviewProvider {
    
    static var userController = UserController()
    static var previews: some View {
        PostView(isLogInPushed: false, userController: userController, post: PostModel(id: "5696", title: "测试标题", author: "ByteDance", publishTime: "2020 年 11 月 22 日", type: 4, cover: ["tb09_3", "tb09_2", "tb09_1"]))
    }
}
