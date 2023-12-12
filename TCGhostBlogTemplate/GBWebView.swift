//
//  GBWebView.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/18/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import SwiftUI
import Combine
import WebKit

public class WebViewStore: ObservableObject {
    
    @Published public var webView: WKWebView
    @Published public var showSafariView:Bool
    @Published public var url:URL?
    
    @EnvironmentObject var ghostData:GhostData
    
    var delegate:NavCoordinator?
    
    public init(webView: WKWebView = WKWebView()) {
        self.webView = webView
        self.showSafariView = false
        
        delegate = NavCoordinator(navCallback: { newURL in
            DispatchQueue.main.async {
                self.url = newURL
                self.showSafariView = true
            }
        })
        
        self.webView.navigationDelegate = self.delegate
    }

    
    class NavCoordinator: NSObject, WKNavigationDelegate {
        
        var navCallback:(URL)->()
        init(navCallback:@escaping (URL)->()) {
            self.navCallback = navCallback
        }
        
        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            // This is our local html content fetched from Ghost Blog API
            guard let newURL = navigationAction.request.url, let scheme = newURL.scheme, scheme.contains("http") else {
                decisionHandler(.allow)
                return
            }
            
            // This is user trying to click link in blog post.
            decisionHandler(.cancel)
            navCallback(newURL)
        }
    }
}


/// A container for using a WKWebView in SwiftUI
public struct WebView: View, UIViewRepresentable {
  /// The WKWebView to display
  public let webView: WKWebView
  
  public typealias UIViewType = UIViewContainerView<WKWebView>
  
  public init(webView: WKWebView) {
    self.webView = webView
  }
  
  public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WebView.UIViewType {
    return UIViewContainerView()
  }
  
  public func updateUIView(_ uiView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>) {
    // If its the same content view we don't need to update.
    if uiView.contentView !== webView {
      uiView.contentView = webView
    }
  }
}

/// A UIView which simply adds some view to its view hierarchy
public class UIViewContainerView<ContentView: UIView>: UIView {
  var contentView: ContentView? {
    willSet {
      contentView?.removeFromSuperview()
    }
    didSet {
      if let contentView = contentView {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
          contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
          contentView.topAnchor.constraint(equalTo: topAnchor),
          contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
      }
    }
  }
}
