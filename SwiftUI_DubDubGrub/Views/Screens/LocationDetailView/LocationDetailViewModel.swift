//
//  LocationDetailViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 10/12/21.
//

import SwiftUI

final class LocationDetailViewModel: ObservableObject {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var location: DDGLocation
    
    init(location: DDGLocation) {
        self.location = location
    }
    
    
}
