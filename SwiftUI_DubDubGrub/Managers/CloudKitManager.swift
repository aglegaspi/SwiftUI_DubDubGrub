//
//  CloudKitManager.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/12/21.
//

import CloudKit

final class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    private init() {}
    
    var userRecord: CKRecord?
    
    func getUserRecord() {
        
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                self.userRecord = userRecord
                print(self.userRecord)
            }
        }
    }
    
    // communication with CloudKit get locations, fetch users checking in, save profile, download profile
    func getLocations(completed: @escaping (Result<[DDGLocation], Error>) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        
        // query the record type "location" and give me all the locations
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescriptor]
        
        // main container of app
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard error == nil else {
                completed(.failure(error!))
                return
            }
            
            guard let records = records else { return }
            
            let locations = records.map(DDGLocation.init)
            
            completed(.success(locations))
            
        }
    }
}
