//
//  GhostBlogSettings.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/18/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import Foundation
import SwiftUI

class GhostBlogSettings {
    
    /* -------------- CHANGE BLOG SETTINGS HERE -------------- */
    
    static let GhostAPIKey:String = "7be2c49a00bc52c28290d93096"
    static let GhostBlogDomain:String = "https://gpte.ai"
    static let GhostBlogAPIVersion:String = "v3"
    
    static let GhostBlogLogoName:String = "Brand_Logo" // Add Logo To Assets (Name goes here)
    static let GhostBlogLogoBackground:Color = Color("Reverse_Background") // Color to go behind Logo
    
    // Content to show on Paid and Members Only Posts... Currently Doesn't support logging in.
    static var PaidPostTemplate:String {
        return "<aside class=\"post-upgrade-cta\"><div class=\"post-upgrade-cta-content\"><h2>This post is for paying subscribers only</h2><a class=\"button large primary\" href=\"\(GhostBlogDomain)\">View On Website</a><p><small>You can't view this post within the app.</small></p></div></aside>"
    }
    
    static var MembersPostTemplate:String {
       return "<aside class=\"post-upgrade-cta\"><div class=\"post-upgrade-cta-content\"><h2>This post is for subscribers only</h2><a class=\"button large primary\" href=\"\(GhostBlogDomain)\">View On Website</a><p><small>You can't view this post within the app.</small></p></div></aside>"
    }
    
    /* -------------- END BLOG SETTINGS -------------- */
    
    static var GhostPostAPIURL:String {
        return "\(GhostBlogDomain)/ghost/api/\(GhostBlogAPIVersion)/content/posts/?key=\(GhostAPIKey)&include=authors,tags&formats=html"
    }
    
    // Used to build a local version of Ghost Post
    static let PostHeader: String = "<html><head><style type=\"text/css\">"
    static let PostMiddle: String = "</style></head><body class=\"post-template\"><div class=\"site-wrapper\"><main id=\"site-main\" class=\"site-main outer\"><div class=\"inner\"><article class=\"post-full post\"><section class=\"post-full-content\"><div class=\"post-content\">"
    static let PostFooter: String = "</div></section></article></div></main></div></body></html>"
    
    // Builds the Post content which is displayed when the user selects a specific post.
    static func buildPostContent(content: String) -> String {
        if let globalCSSPath = Bundle.main.path(forResource: "global", ofType: "css"), let screenCSSPath = Bundle.main.path(forResource: "screen", ofType: "css") {
            do {
                let globalContents = try String(contentsOfFile: globalCSSPath)
                let screenContents = try String(contentsOfFile: screenCSSPath)
                
                return "\(PostHeader) \(globalContents) \(screenContents) \(PostMiddle) \(content) \(PostFooter)"
                
            } catch {
                return "\(PostHeader) \(PostMiddle) \(content) \(PostFooter)"
            }
        }
        return "\(PostHeader) \(PostMiddle) \(content) \(PostFooter)"
    }
    
    
    
}
