//
//  LocationListViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 10/27/21.
//

import CloudKit

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
    
    func getCheckedInProfilesDictionary() {
        CloudKitManager.shared.getCheckedInProfilesDictionary { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkedInProfiles):
                    self.checkedInProfiles = checkedInProfiles
                    print(checkedInProfiles)
                case .failure(_):
                    print("error retrieving dictionay")
                } //Switch
            } //Dispatch
            
        } //CloudKitManager
    } //getCheckedInProfilesDictionary
}
