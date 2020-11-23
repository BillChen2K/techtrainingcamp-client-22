//
//  HtmlView.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/23.
//

import SwiftUI
import WebKit

struct HtmlView: UIViewRepresentable {
    @Binding var htmlString: String
    
    @State var height: CGFloat = 500
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
    
}

struct HtmlView_Previews: PreviewProvider {
    @State static var str = "<b>Hello, HTML.</b></br></br></br>HI"
    static var previews: some View {
        HtmlView(htmlString: $str)
    }
}

