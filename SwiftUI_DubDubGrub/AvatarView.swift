//
//  AvatarView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/6/21.
//

import SwiftUI

struct AvatarView: View {
    
    var size: CGFloat
    
    var body: some View {
        Image("default-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(size: 90)
    }
}
