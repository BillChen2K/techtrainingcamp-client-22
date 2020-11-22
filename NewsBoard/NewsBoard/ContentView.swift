//
//  ContentView.swift
//  newsboard
//
//  Created by Bill Chen on 2020/11/21.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading = true
    
    var body: some View {
        LoadingView(isLoading: $isLoading) {
            FeedView(isLoading: $isLoading)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
