//
//  LocationListViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 10/27/21.
//

import CloudKit
import SwiftUI

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
    
    func getCheckedInProfilesDictionary() {
        CloudKitManager.shared.getCheckedInProfilesDictionary { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkedInProfiles):
                    self.checkedInProfiles = checkedInProfiles
                case .failure(_):
                    print("error retrieving dictionay")
                } //Switch
            } //Dispatch
            
        } //CloudKitManager
    } //getCheckedInProfilesDictionary
    
    
    func countVoiceOverSummary(for location: DDGLocation) -> String {
        let count = checkedInProfiles[location.id, default: []].count
        
        return count == 1 ? "\(count) person checked in" : "\(count) people checked in"
    }
    
    
    @ViewBuilder func createLocationDetailView(for location: DDGLocation, in sizeCategory: ContentSizeCategory) -> some View {
        if sizeCategory >= .accessibilityLarge {
            LocationDetailView(viewModel: LocationDetailViewModel(location: location)).embedInScrollView()
        } else {
            LocationDetailView(viewModel: LocationDetailViewModel(location: location))
        }
    }
}
