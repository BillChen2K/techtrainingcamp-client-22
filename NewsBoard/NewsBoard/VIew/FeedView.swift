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
    
    var body: some View {
        NavigationView {
            LoadingView(isLoading: $isLoading) {
                ScrollView() {
                    ForEach(feedController.feedList) {onePost in
                        NavigationLink(
                            destination: PostView(post: onePost),
                            label: {
                                FeedListItem(post: onePost)
                            })
                    }
                    Image("ByteDanceLogo").resizable().aspectRatio(contentMode: .fit).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).padding()
                    Text("")
                }.animation(.easeIn(duration: 0.5)).transition(.opacity)
            }
            
            .onAppear() {
                //                let _ = feedController.loadFeedList()
                isLoading = false
            }
            .navigationTitle("公告板")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    NavigationLink(
                                        destination: LogInView(),
                                        label: {
                                            HStack {
                                                Text(userController.currentUser?.username ?? "未登录").font(.callout)
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
