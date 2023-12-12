//
//  PostView.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/18/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import SwiftUI
import URLImage
import WebKit
import SafariServices

struct PostView: View {
    
    @State var post:GhostData.GhostPost
    @State var showSafariView:Bool = false
    
    @ObservedObject var webViewStore:WebViewStore = WebViewStore()
    
    var body: some View {
        WebView(webView: webViewStore.webView)
            .onAppear {
                self.webViewStore.webView.loadHTMLString(GhostBlogSettings.buildPostContent(content: self.post.content), baseURL: nil)
            }
            .sheet(isPresented: $webViewStore.showSafariView, content: {
                SafariView(url: self.webViewStore.url!)
            })
            .navigationBarTitle(Text(post.title), displayMode: .inline)
            .edgesIgnoringSafeArea(.vertical)
            
    }
    
}

struct PostView_Previews: PreviewProvider {
    
    static let post = GhostData.GhostPost(title: "Testing Ghost Post Layout", detail: "Test post made for Ghost Blog App", imageURL: URL(string: "https://trailingclosure.com/content/images/2019/12/E-Commerce_Template.png"), author: "Jean-Marc Boullianne", date: "January 18", tag: "Test", id: "TestPost123", content: "<!--kg-card-begin: markdown--><p>We're happy to provide our new E-Commerce Template. The template was developed completely in SwiftUI. This template will give you a huge head start on your new iOS or SwiftUI project. It comes preloaded with lots of custom Trailing Closure goodies:</p>\n<ul>\n<li>Custom Tab Bar!</li>\n<li>Custom Dual Column Lists!</li>\n<li>Custom Rating Block!</li>\n<li>Custom Activity Sharing Sheet!</li>\n<li>Custom Product Structs to get you started!</li>\n</ul>\n<p>You're going to love not only using this template, but taking bits for future projects!</p>\n<!--kg-card-end: markdown--><figure class=\"kg-card kg-gallery-card kg-width-wide\"><div class=\"kg-gallery-container\"><div class=\"kg-gallery-row\"><div class=\"kg-gallery-image\"><img src=\"https://trailingclosure.com/content/images/2019/12/main.png\" width=\"1168\" height=\"2096\"></div><div class=\"kg-gallery-image\"><img src=\"https://trailingclosure.com/content/images/2019/12/product_detail.png\" width=\"1168\" height=\"2096\"></div><div class=\"kg-gallery-image\"><img src=\"https://trailingclosure.com/content/images/2019/12/cart.png\" width=\"1168\" height=\"2096\"></div></div></div></figure><!--kg-card-begin: markdown--><p><a href=\"https://github.com/jboullianne/TC-ECommerceTemplate\">Link to GitHub Project</a> to download and start coding!</p>\n<p>Let us know what you think on Twitter or on Instagram! Also please consider subscribing and supporting our future work. Thanks!</p>\n<!--kg-card-end: markdown-->", postURL: "")
    
    static var previews: some View {
        PostView(post: post)
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }
}
