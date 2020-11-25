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

struct MarkdownDisplayer: View {
    
    @State var content: String = "" {
        didSet {
            self.htmlString = markdownToHTML(markString: content)
            print("Set")
        }
    }
    
    @State var htmlString: String = "" {
        didSet{
            print(self.htmlString)
        }
    }
    @State var viewHeight: CGFloat = 500
    @State var isLoading = true

    fileprivate func iniJsContext() {
        let jsPath = Bundle.main.path(forResource: "showdown", ofType: "js")
        let jsContentData = FileManager.default.contents(atPath: jsPath!)
        let jsContent = NSString(data: jsContentData!, encoding: String.Encoding.utf8.rawValue) as String?
        jsContext.evaluateScript(jsContent)
        // 定义JS函数
        jsContext.evaluateScript("""
            function convert(md) {
            return (new showdown.Converter({'splitAdjacentBlockquotes': true})).makeHtml(md);
            }
            """)
    }

    fileprivate func markdownToHTML(markString: String) -> String {
        iniJsContext()
        //调用JS方法
        let mthJS = jsContext.evaluateScript("convert")
        let result = mthJS?.call(withArguments: [markString])
        return """
            <html>
            <head>
            <link rel="stylesheet" href="markdown.css">
            </head>
            <body>
            \(result!.toString()!)
            </body>
            </html>

            """
    }
    
    var body: some View {
        VStack {
            HtmlView(htmlString: $htmlString, urlString: URL(fileURLWithPath:cssPath!)).opacity(isLoading ? 0 : 1).transition(.opacity).animation(.easeInOut(duration: 0.2))
                
        }.onAppear(){
            self.htmlString = markdownToHTML(markString: content)
            DispatchQueue.main.asyncAfter(deadline: .now() +  0.3) {
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
