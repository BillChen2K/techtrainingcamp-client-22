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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        LoadingView(isLoading: $isLoading) {
            VStack {
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                        isLoading = false
                        self.presentationMode.wrappedValue.dismiss()

                    }
                }) {
                    ZStack {
                        Rectangle().frame(width: 256, height: 48).cornerRadius(6)
                        Text("Log In").font(.callout).foregroundColor(.white)
                    }
                }.padding()
                
            }.padding()
        }
       
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
