//
//  ContentView.swift
//  Markdown
//
//  Created by Yunjian Lin on 2020/11/19.
//  Copyright © 2020 Yunjian Lin. All rights reserved.
//

import SwiftUI
import WebKit
import JavaScriptCore


let jsContext: JSContext = JSContext()
let cssPath = Bundle.main.path(forResource: "markdown", ofType: "css")

let cssContentData = FileManager.default.contents(atPath: cssPath!)
let cssContent = NSString(data: cssContentData!, encoding: String.Encoding.utf8.rawValue) as String?

struct MarkdownDisplayer: View {
    
    @State var content: String = "" {
        didSet {
            self.htmlString = markdownToHTML(markString: content)
            print("Set")
        }
    }
    @State var htmlString = ""
    @State var viewHeight: CGFloat = 500
    @State var isLoading = true

    fileprivate func iniJsContext() {
        let jsPath = Bundle.main.path(forResource: "showdown", ofType: "js")
        let jsContentData = FileManager.default.contents(atPath: jsPath!)
        let jsContent = NSString(data: jsContentData!, encoding: String.Encoding.utf8.rawValue) as String?
        jsContext.evaluateScript(jsContent)
        // 定义JS函数
        jsContext.evaluateScript("""
            function convert(md) {return (new showdown.Converter({'splitAdjacentBlockquotes': true})).makeHtml(md);}
            """)
    }

    fileprivate func markdownToHTML(markString: String) -> String {
        iniJsContext()
        //调用JS方法
        let mthJS = jsContext.evaluateScript("convert")
        let result = mthJS?.call(withArguments: [markString])
        return "<html>\n<head>\n<title></title>\n<style>\n" + cssContent! + "</style>\n</head>\n                <body>\n" + result!.toString() + "</body>\n</html>\n"
    }
    
    var body: some View {
        VStack {
            HtmlView(htmlString: $htmlString).opacity(isLoading ? 0 : 1).transition(.opacity).animation(.easeInOut(duration: 0.25))
                
        }.onAppear(){
            self.htmlString = markdownToHTML(markString: content)
            DispatchQueue.main.asyncAfter(deadline: .now() +  0.2) {
                self.isLoading = false
            }
        }
    }
}

struct MarkdownDisplayer_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownDisplayer(content: "## Hi. This is a strting. \n Hi.  Why don't you let me see? \n\n\n\nWow!")
    }
}
