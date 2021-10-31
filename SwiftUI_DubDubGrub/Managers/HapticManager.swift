//
//  HapticManager.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 10/31/21.
//

import UIKit

struct HapticManager {
    
    static func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
}
