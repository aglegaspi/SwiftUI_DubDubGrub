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
    
    
    func playHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    
    // dismissed the keyboard when this function is called
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
