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
    var profileRecordID: CKRecord.ID?
    let container = CKContainer.default()
    
    //    func getUserRecord() {
    //        CKContainer.default().fetchUserRecordID { recordID, error in
    //            guard let recordID = recordID, error == nil else {
    //                print(error!.localizedDescription)
    //                return
    //            }
    //
    //            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
    //                guard let userRecord = userRecord, error == nil else {
    //                    print(error!.localizedDescription)
    //                    return
    //                }
    //
    //                self.userRecord = userRecord
    //
    //                if let profileReference = userRecord["userProfile"] as? CKRecord.Reference {
    //                    self.profileRecordID = profileReference.recordID
    //                }
    //            }
    //        }
    //    }
    
    
    func getUserRecord() async throws {
        
        let recordID = try await container.userRecordID()
        let record = try await container.publicCloudDatabase.record(for: recordID)
        userRecord = record
        
        if let profileReference = record["userProfile"] as? CKRecord.Reference {
            profileRecordID = profileReference.recordID
        }
    }
    
    
    // communication with CloudKit get locations, fetch users checking in, save profile, download profile
    func getLocations() async throws -> [DDGLocation] {
        let sortDescriptor = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        
        // query the record type "location" and give me all the locations
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescriptor]
        
        let (matchResults, _) = try await container.publicCloudDatabase.records(matching: query)
        let records = matchResults.compactMap { _, result in try? result.get() }
        return records.map(DDGLocation.init)
    }

    
    
    func getCheckedInProfiles(for locationID: CKRecord.ID) async throws -> [DDGProfile] {
        let reference = CKRecord.Reference(recordID: locationID, action: .none)
        // whoever is checked in is equal to our reference (locationID)
        let predicate = NSPredicate(format: "isCheckedIn == %@", reference)
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        
        let (matchResults, _) = try await container.publicCloudDatabase.records(matching: query)
        let records = matchResults.compactMap { _, result in try? result.get() }
        return records.map(DDGProfile.init)
    }
    
    
    func getCheckedInProfilesDictionary(completed: @escaping (Result<[CKRecord.ID : [DDGProfile]], Error>) -> Void) {
        //print("✅ Network call fired off")
        let predicate = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        //operation.resultsLimit = 1
        //operation.desiredKeys = [DDGProfile.kIsCheckedIn,DDGProfile.kAvatar]
        var checkedInProfiles: [CKRecord.ID : [DDGProfile]] = [:]
        
        operation.recordFetchedBlock = { record in
            let profile = DDGProfile(record: record)
            guard let locationReference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference else { return }
            checkedInProfiles[locationReference.recordID, default: []].append(profile)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            guard error == nil else {
                completed(.failure(error!))
                return
            }
            
            if let cursor = cursor {
                //print("1️⃣ initial cursor is not nil")
                //print("👨‍👩‍👧‍👦 Current dictionary - \(checkedInProfiles)")
                self.continueWithCheckedInProfilesDictionary(cursor: cursor, dictionary: checkedInProfiles) { result in
                    switch result {
                    case .success(let profiles):
                        //print("♻️✅ initial recursive success - dictionary - \(profiles)")
                        completed(.success(profiles))
                    case .failure(let error):
                        //print("♻️🛑 initial recursive error \(error)")
                        completed(.failure(error))
                    }
                }
            } else {
                completed(.success(checkedInProfiles))
            } // if let else
            
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    
    func continueWithCheckedInProfilesDictionary(cursor: CKQueryOperation.Cursor,
                                                 dictionary: [CKRecord.ID : [DDGProfile]],
                                                 completed: @escaping (Result<[CKRecord.ID : [DDGProfile]], Error>) -> Void) {
        
        var checkedInProfiles = dictionary
        let operation = CKQueryOperation(cursor:  cursor)
        //operation.resultsLimit = 1
        
        operation.recordFetchedBlock = { record in
            let profile = DDGProfile(record: record)
            guard let locationReference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference else { return }
            checkedInProfiles[locationReference.recordID, default: []].append(profile)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            guard error == nil else { completed(.failure(error!)); return }
            
            if let cursor = cursor {
                //print("♻️ recursive cursor is not nil")
                //print("👨‍👩‍👧‍👦 Current dictionary - \(checkedInProfiles)")
                
                self.continueWithCheckedInProfilesDictionary(cursor: cursor, dictionary: checkedInProfiles) { result in
                    switch result {
                    case .success(let profiles):
                        //print("♻️✅ recursive success - dictionary - \(profiles)")
                        completed(.success(profiles))
                    case .failure(let error):
                        //print("♻️🛑 recursive error \(error)")
                        completed(.failure(error))
                    }
                }
            } else {
                completed(.success(checkedInProfiles))
            } // if let else
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    
    func getCheckedInProfilesCount(completed: @escaping (Result<[CKRecord.ID : Int], Error>) -> Void) {
        let predicate = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = [DDGProfile.kIsCheckedIn]
        
        var checkedInProfiles: [CKRecord.ID : Int] = [:]
        
        operation.recordFetchedBlock = { record in
            guard let locationReference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference else { return }
            
            if let count = checkedInProfiles[locationReference.recordID] {
                checkedInProfiles[locationReference.recordID] = count + 1
            } else {
                checkedInProfiles[locationReference.recordID] = 1
            }
        }
        operation.queryCompletionBlock = { cursor, error in
            guard error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(checkedInProfiles))
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    
    // MARK: - REUABLE METHODS
    func batchSave(records: [CKRecord], completed: @escaping (Result<[CKRecord], Error>) -> Void) {
        // Create a CKOperation to save our User and Profile Records
        let operation = CKModifyRecordsOperation(recordsToSave: records)
        
        operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
            guard let savedRecords = savedRecords, error == nil else {
                print(error!.localizedDescription)
                completed(.failure(error!))
                return
            }
            completed(.success(savedRecords))
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    } //batchSave
    
    
    func save(record: CKRecord, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            guard let record = record, error == nil else {
                completed(.failure(error!))
                return
            }
            
            completed(.success(record))
        }
    } //save
    
    
    func fetchRecord(with id: CKRecord.ID, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        // fetch record based on ID
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { record, error in
            guard let record = record, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(record))
        }
    } //fetchRecords
    
} // CloudKitManager
