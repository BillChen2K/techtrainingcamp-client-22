//
//  FeedView.swift
//  newsboard
//
//  Created by Bill Chen on 2020/11/22.
//

import SwiftUI

struct FeedView: View {
    @State var isLoading: Bool = false
    
    @ObservedObject var feedController = FeedController()
    @ObservedObject var userController = UserController()

    func getPostDestination(_ post: PostModel) -> AnyView {
        return userController.loginStatus == LoginStatus.loggedOut ? AnyView(LogInView(userController: userController)) : AnyView(PostView(isLogInPushed: false, userController: userController, post: post))
    }
    
    
    var body: some View {
        
        NavigationView {
            ScrollView() {
                HStack {
                    Spacer()
                }
                ForEach(feedController.feedList) {onePost in
                    NavigationLink(
                        destination: getPostDestination(onePost),
                        label: {
                            FeedListItem(post: onePost)
                        }).transition(.opacity)
                }
                Image("ByteDanceLogo").resizable().aspectRatio(contentMode: .fit).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).padding()
                Text("")
            }
            .onAppear() {
                //                let _ = feedController.loadFeedList()
                self.isLoading = false
            }
            .navigationTitle("公告板")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    NavigationLink(
                                        destination: LogInView(userController: userController),
                                        label: {
                                            HStack {
                                                Text(userController.loginStatus == LoginStatus.loggedIn || userController.loginStatus == LoginStatus.cached ? userController.currentUser!.username! : "未登录").font(.callout)
                                                Image(systemName: "person.fill").padding(6)
                                            }
                                        })
                                    
                                    .padding(.vertical, 6))
        }.accentColor(Color(hex: 0x375FCC))
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
