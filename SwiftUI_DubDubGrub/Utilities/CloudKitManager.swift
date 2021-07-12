//
//  CloudKitManager.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/12/21.
//

import CloudKit

struct CloudKitManager {
    // communication with CloudKit get locations, fetch users checking in, save profile, download profile
    
    static func getLocations(completed: @escaping (Result<[DDGLocation], Error>) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        // query the record type and give me all the locations
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescriptor]
        
        // main container of app
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard error == nil else {
                completed(.failure(error!))
                return
            }
            
            guard let records = records else { return }
            
            var locations: [DDGLocation] = []
            
            
            
        }
    }
    
}
