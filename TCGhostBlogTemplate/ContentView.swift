//
//  ContentView.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/14/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import SwiftUI
import SwiftyJSON


struct ContentView: View {
    
    @EnvironmentObject var ghostData:GhostData
    
    @State private var contentOffset:CGFloat = 0.0
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        NavigationView {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)
            GeometryReader { geometry in
                List {
                    Rectangle()
                    .frame(width: nil, height: 120, alignment: .center)
                    .foregroundColor(GhostBlogSettings.GhostBlogLogoBackground)
                    .overlay(
                        Image(GhostBlogSettings.GhostBlogLogoName)
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 20)
                        .padding(.top, 30)
                    ).padding(.horizontal, -30)
                    .padding(.top, -10)
                    
                    ForEach(self.ghostData.posts, id: \.id) { post in
                        VStack {
                            NavigationLink(destination: PostView(post: post)) {
                                PostRow(title: post.title, detail: post.detail, imageURL: post.imageURL, author: post.author, date: post.date, tag: post.tag)
                                    .padding(.vertical, 15)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                    Rectangle()
                        .frame(width: 0, height: 0, alignment: .center)
                    .onAppear {
                        self.ghostData.requestNextPosts()
                        print("Last Post Did Appear")
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .zIndex(1)
                    /*
                    ScrollView(.vertical, showsIndicators: false) {
                            VStack{
                                Rectangle()
                                    .frame(width: nil, height: 120, alignment: .center)
                                    .foregroundColor(GhostBlogSettings.GhostBlogLogoBackground)
                                    .overlay(
                                        Image(GhostBlogSettings.GhostBlogLogoName)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.vertical, 20)
                                        .padding(.top, 30)
                                    ).padding(.horizontal, -16)
                                
                                ForEach(self.ghostData.posts, id: \.id) { post in
                                    VStack {
                                        
                                        NavigationLink(destination: PostView(post: post)) {
                                            PostRow(title: post.title, detail: post.detail, imageURL: post.imageURL, author: post.author, date: post.date, tag: post.tag)
                                                .padding(.vertical, 20)
                                        }.buttonStyle(PlainButtonStyle())
                                        
                                        Divider()
                                        .background(Color.gray)
                                    }
                                    
                                }
                            }
                            .padding(.horizontal, 16)
                            .frame(width: geometry.size.width, height: nil, alignment: .top)
                            //.modifier(OnScroll(offset: self.$contentOffset))
                        
                    }
                    .edgesIgnoringSafeArea(.vertical)
                    .zIndex(1)
                    
                    */

            }
            
            if contentOffset < -10 {
                VStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .overlay(
                            Image("TC_Logo")
                                .resizable()
                                .scaledToFit()
                                .padding(.top, 50)
                                .padding(.bottom, 15)
                        )
                    .frame(width: nil, height: 100, alignment: .top)
                    .foregroundColor(Color(red: 37/255, green: 38/255, blue: 39/255))
                    Spacer()
                }
                
                .edgesIgnoringSafeArea(.top)
                .animation(.easeInOut(duration: 0.5))
                .transition(.move(edge: .top))
                .zIndex(2)
                    
            }
            
        }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
