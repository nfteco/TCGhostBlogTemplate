//
//  TagView.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/14/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import SwiftUI

struct TagView: View {
    
    @State var tag:String
    @State var color:Color
    
    var body: some View {
        Text(tag)
            .font(Font.system(size: 18, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .padding(.leading, 12)
            .padding(.bottom, 9)
            .frame(width: 150, height: 90, alignment: .bottomLeading)
            .background(self.color)
        .cornerRadius(7)
    }
}

struct TagView_Previews: PreviewProvider {
    
    static let tag = "SwiftUI"
    static let color = Color(red: 30/255, green: 168/255, blue: 124/255)
    
    static var previews: some View {
        TagView(tag: tag, color: color)
    }
}
