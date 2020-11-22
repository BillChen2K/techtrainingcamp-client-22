//
//  LoadingView.swift
//  newsboard
//
//  Created by Bill Chen on 2020/11/21.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var isLoading: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .center) {
            
            self.content()
                .disabled(self.isLoading)
                .blur(radius: self.isLoading ? 3 : 0)
                .animation(.easeIn(duration: 0.2))
            if(self.isLoading) {
                HStack {
                    LoadingIndicator(strokeColor: .black, size: .Small)
                        .padding()
                    Text("正在加载...")
                }
                .foregroundColor(Color.primary)
                .cornerRadius(12)
                .opacity(self.isLoading ? 1 : 0)
                .animation(.easeIn(duration: 0.2))
            }
            
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true)) {
            Text("Hello, world!")
                .padding()
        }
        
    }
}

