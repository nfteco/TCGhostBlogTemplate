//
//  PostRow.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/14/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import SwiftUI
import URLImage

struct PostRow: View {
    
    @State var title:String
    @State var detail:String
    @State var imageURL:URL?
    @State var author:String
    @State var date:String
    @State var tag:String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Font.system(size: 20, weight: .bold, design: .default))
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color("PrimaryText"))
                    
                    if detail != "" {
                        Text(detail)
                            .font(Font.system(size: 13, weight: .semibold, design: .default))
                            .foregroundColor(.gray)
                        .lineLimit(1)
                    }
                    
                    
                    HStack(alignment: .bottom, spacing: 16) {
                        
                        Text(date)
                        .font(Font.system(size: 13, weight: .semibold, design: .default))
                        .foregroundColor(.gray)
                        Text("#\(tag)")
                        .font(Font.system(size: 13, weight: .semibold, design: .default))
                        .foregroundColor(Color("SecondaryText"))
                        
                        
                        Spacer()
                        //Image(systemName: "bookmark")
                        //    .foregroundColor(.gray)
                        //Image(systemName: "ellipsis")
                        //    .foregroundColor(.gray)
                        
                    }
                }
                Spacer()
                
                if imageURL != nil {
                    URLImage(imageURL!, placeholder: { _ in 
                        Rectangle()
                        .frame(width: 70, height: 70, alignment: .center)
                        .background(Color.gray)
                        .cornerRadius(4)
                        .clipped()
                    }, content: {
                        $0.image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70, alignment: .center)
                        .background(Color.gray)
                        .cornerRadius(4)
                        .clipped()
                    })
                }
            }
            
            
            //.modifier(RowTagModifier())
            /*Text(author)
                .font(Font.system(size: 13, weight: .semibold, design: .default))
                .foregroundColor(Color("SecondaryText"))
            *//*
            HStack(alignment: .bottom, spacing: 16) {
                
                Text(date)
                .font(Font.system(size: 13, weight: .semibold, design: .default))
                .foregroundColor(.gray)
                Text("#\(tag)")
                .font(Font.system(size: 13, weight: .semibold, design: .default))
                .foregroundColor(Color("SecondaryText"))
                
                
                Spacer()
                //Image(systemName: "bookmark")
                //    .foregroundColor(.gray)
                //Image(systemName: "ellipsis")
                //    .foregroundColor(.gray)
                
            }
            .padding((.trailing), 12)
    */
            
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    
    static let title = "Flow Text Animation using a custom View Modifier"
    static let detail = "Create this cool flowing text animation in SwiftUI using a custom ViewModifier!"
    static let imageURL = URL(string: "https://trailingclosure.com/content/images/2020/01/FlowTextPromo-2.gif")!
    static let author = "Jean-Marc Boullianne"
    static let date = "December 29"
    static let tag = "SwiftUI"
    
    static var previews: some View {
        PostRow(title: title, detail: detail, imageURL: imageURL, author: author, date: date, tag: tag)
    }
}
