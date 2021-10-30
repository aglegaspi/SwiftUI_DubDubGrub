//
//  LogoView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 9/7/21.
//

import SwiftUI

struct LogoView: View {
    
    var frameWidth: CGFloat
    
    var body: some View {
        // initializes image so the string is not read during voice over (accessibility)
        Image(decorative: "ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth)
            
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(frameWidth: 250)
    }
}
