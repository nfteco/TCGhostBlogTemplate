//
//  OnScroll.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/18/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import SwiftUI
import Combine

struct OnScroll: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        return VStack {
            GeometryReader { geometry -> ForEach<Range<Int>, Int, EmptyView> in
                let newOffset = geometry.frame(in: .global).maxY
                print("Content Offset:", newOffset)
                //this can trigger a rerender. Checking for equality breaks the infinite loop.
                withAnimation {
                   if self.offset != newOffset { self.offset = newOffset }
                }
                
                // for some reason with EmptyView or any other View the GeometryReader never got called, but with empty ForEach it does
                return ForEach(0..<0) { _ in
                    return EmptyView()
                }
            }
            content
        }
    }
}
