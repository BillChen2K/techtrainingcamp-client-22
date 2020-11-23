//
//  LogInView.swift
//  newsboard
//
//  Created by Bill Chen on 2020/11/22.
//

import SwiftUI

struct LogInView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoading: Bool = false
    @State var ifRemember: Bool = true
    
    @ObservedObject var userController: UserController
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func getNotifText() -> String {
        switch userController.loginStatus {
        case .loggedOut:
            return "Please log in to view posts."
        case .outdated:
            return "Your credential is outdated."
        default:
            return "Please log in to view posts."
        }
    }
    
    var body: some View {
        LoadingView(isLoading: $isLoading) {
            VStack {
                if (self.userController.loginStatus == .loggedIn || self.userController.loginStatus == .cached) {
                    Text("Welcome, \(userController.currentUser!.username!).").font(.title3).fontWeight(.bold).padding()
                    Text("You've logged in since \(MyDateFormatter.dateToString(from: userController.currentUser!.logInTime!)).").font(.callout)
                    Button(action: {
                        userController.performlogOut()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Rectangle().frame(width: 256, height: 48).cornerRadius(6)
                            Text("Log Out").font(.callout).foregroundColor(.white)
                        }
                    }.padding()
                }
                
                else {
                    HStack {
                        Image(systemName: "info.circle.fill").padding(.leading)
                        Text(self.getNotifText()).padding().foregroundColor(.primary).font(.callout)
                    }.background(Color.accentColor.opacity(0.2)).cornerRadius(6)
                    
                    HStack {
                        Text("Username").font(.callout).frame(width: 80, alignment: .leading)
                        TextField("Please enter username", text: $username).font(.callout) .frame(width: 200).padding(6)
                            .overlay(Rectangle().frame(height: 1, alignment: .leading).foregroundColor(Color.gray), alignment: .bottom)
                    }.padding(12)
                    HStack {
                        Text("Password").font(.callout).frame(width: 80, alignment: .leading)
                        
                        SecureField("Please enter password", text: $password).font(.callout).frame(width: 200).padding(6)
                            .overlay(Rectangle().frame(height: 1, alignment: .leading).foregroundColor(Color.gray), alignment: .bottom)
                    }.padding(12)
                    Button(action: {
                        isLoading = true
                        userController.performLogIn(username: username, password: password, remember: ifRemember) { result in
                            isLoading = false
                            if result == .success {
                                presentationMode.wrappedValue.dismiss()
                            }
                            else {
                                
                            }
                        }
                        
                    }) {
                        ZStack {
                            Rectangle().frame(width: 256, height: 48).cornerRadius(6)
                            Text("Log In").font(.callout).foregroundColor(.white)
                        }
                    }.padding()
                    Toggle(isOn: $ifRemember) {
                        Text("Remember").font(.callout)
                    }.frame(width: 150)
                    .toggleStyle(CheckboxStyle())
                }
            }.padding()
            
        }
        .navigationTitle([LoginStatus.cached, LoginStatus.loggedIn].contains(userController.loginStatus) ? "User Center" : "Log In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var userController = UserController()
    
    static var previews: some View {
        
        LogInView(userController: userController)
//            .environment(\.colorScheme, .dark)
    }
}
