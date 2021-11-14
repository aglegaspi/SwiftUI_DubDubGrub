//
//  View+Ext.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/6/21.
//

import SwiftUI

extension View {
    
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }
    
    
    func embedInScrollView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                frame(minHeight: geometry.size.height,
                      maxHeight: .infinity)
            }
        }
    }

}
