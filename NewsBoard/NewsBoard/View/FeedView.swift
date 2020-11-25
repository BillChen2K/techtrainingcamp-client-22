//
//  FeedView.swift
//  newsboard
//
//  Created by Bill Chen on 2020/11/22.
//

import SwiftUI

struct FeedView: View {
    @State var animationHandle : Bool = true
    
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
                ForEach(0..<feedController.feedList.count) {i in
                    NavigationLink(
                        destination: getPostDestination(feedController.feedList[i]),
                        label: {
                            FeedListItem(post: feedController.feedList[i])
                                .opacity(animationHandle ? 0 : 1)
                                .offset(x: 0, y: animationHandle ? 50 : 0)
                                .animation(Animation.timingCurve(0, 0.6, 0.4, 1, duration: 0.8).delay(0.1 * Double(i)))
                        })
                }
                Image("ByteDanceLogo").resizable().aspectRatio(contentMode: .fit).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).padding()
                    .onTapGesture {
                        self.animationHandle.toggle()
                    }
                Text("")
                #if targetEnvironment(macCatalyst)
                Text("You are running NewsBoard with MacCatalyst.").font(.caption).foregroundColor(.gray)
                #endif
            }
            .onAppear() {
                //                let _ = feedController.loadFeedList()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.animationHandle = false

                }
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
