//
//  RowTagModifier.swift
//  TCGhostBlogTemplate
//
//  Created by Jean-Marc Boullianne on 1/14/20.
//  Copyright © 2020 TrailingClosure. All rights reserved.
//

import Foundation
import SwiftUI

struct RowTagModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.gray)
            .font(Font.system(size: 15, weight: .semibold, design: .monospaced))
    }
    
}
