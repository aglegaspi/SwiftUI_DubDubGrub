//
//  AlertItem.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/13/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dissmissButton: Alert.Button
}

