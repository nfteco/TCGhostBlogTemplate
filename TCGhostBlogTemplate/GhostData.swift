//
//  BlogData.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/14/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftUI

class GhostData: ObservableObject {
    
    struct GhostPost {
        var title:String
        var detail:String
        var imageURL:URL?
        var author:String
        var date:String
        var tag:String
        var id:String
        var content:String
        var postURL:String
    }
    
    @Published var posts:[GhostPost] = []
    
    private var currentPage:Int = 0
    private var pageCount:Int = 0
    
    init() {
        guard let url = URL(string: GhostBlogSettings.GhostPostAPIURL) else {
            debugPrint("GhostBlogSettings.GhosPostAPIURL Invalid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, respons, error) in
            print("Received Response")
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    print("Got the JSON")
                    
                    let pageData = json["meta"]["pagination"]
                    self.pageCount = pageData["pages"].intValue
                    self.currentPage = pageData["page"].intValue
                    
                    DispatchQueue.main.async {
                            self.posts = json["posts"].arrayValue.map({ (json) -> GhostPost in
                                
                                let title = json["title"].stringValue
                                let detail = json["custom_excerpt"].stringValue
                                let imageURL = URL(string: json["feature_image"].stringValue)
                                let author = json["primary_author"]["name"].stringValue
                                
                                let dateRaw = json["created_at"].stringValue
                                let inputFormatter = DateFormatter()
                                inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                                let outputFormatter = DateFormatter()
                                outputFormatter.dateFormat = "MMMM dd"
                                let date = outputFormatter.string(from: inputFormatter.date(from: dateRaw) ?? Date())
                                
                                let postURL = json["url"].stringValue
                                
                                let tag = json["primary_tag"]["name"].stringValue
                                let id = json["id"].stringValue
                                
                                var content = json["html"].stringValue
                                
                                let visibility = json["visibility"].stringValue
                                if visibility == "paid" { content = GhostBlogSettings.PaidPostTemplate }
                                if visibility == "members" { content = GhostBlogSettings.MembersPostTemplate }
                                
                                return GhostPost(title: title, detail: detail, imageURL: imageURL, author: author, date: date, tag: tag, id: id, content: content, postURL: postURL)
                                
                                
                            })
        
                        print("Supplied the Ghost Posts", self.posts.count)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            
        }
        task.resume()
    }
    
    func requestNextPosts() {
        let nextPage = self.currentPage + 1
        if nextPage > self.pageCount { return }
        
        guard let url = URL(string: "\(GhostBlogSettings.GhostPostAPIURL)&page=\(nextPage)") else {
            debugPrint("GhostBlogSettings.GhosPostAPIURL Invalid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, respons, error) in
            print("Received Response")
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    print("Got the JSON")
                    
                    let pageData = json["meta"]["pagination"]
                    self.currentPage = pageData["page"].intValue
                    
                    DispatchQueue.main.async {
                        self.posts.append(contentsOf: json["posts"].arrayValue.map({ (json) -> GhostPost in
                                
                                let title = json["title"].stringValue
                                let detail = json["custom_excerpt"].stringValue
                                let imageURL = URL(string: json["feature_image"].stringValue)
                                let author = json["primary_author"]["name"].stringValue
                                
                                let dateRaw = json["created_at"].stringValue
                                let inputFormatter = DateFormatter()
                                inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                                let outputFormatter = DateFormatter()
                                outputFormatter.dateFormat = "MMMM dd"
                                let date = outputFormatter.string(from: inputFormatter.date(from: dateRaw) ?? Date())
                                
                                let postURL = json["url"].stringValue
                                
                                let tag = json["primary_tag"]["name"].stringValue
                                let id = json["id"].stringValue
                                
                                var content = json["html"].stringValue
                                
                                let visibility = json["visibility"].stringValue
                                if visibility == "paid" { content = GhostBlogSettings.PaidPostTemplate }
                                if visibility == "members" { content = GhostBlogSettings.MembersPostTemplate }
                                
                                return GhostPost(title: title, detail: detail, imageURL: imageURL, author: author, date: date, tag: tag, id: id, content: content, postURL: postURL)
                                
                                
                            }))
        
                        print("Supplied the Ghost Posts", self.posts.count)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            
        }
        task.resume()
        
    }
}
