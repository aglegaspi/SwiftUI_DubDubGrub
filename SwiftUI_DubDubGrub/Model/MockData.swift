//
//  MockData.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/8/21.
//

import CloudKit

struct MockData {
    
    static var location: CKRecord {
        let record                          = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName]           = "Alxndr's Bar and Grill"
        record[DDGLocation.kAddress]        = "123 Developer Way"
        record[DDGLocation.kDescription]    = "You are a Professional iOS Developer"
        record[DDGLocation.kWebsiteURL]     = "http://www.dribbble.com"
        record[DDGLocation.kLocation]       = CLLocation(latitude: 37.33156, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber]    = "123-456-7890"
        
        return record
    }
    
    static var profile: CKRecord {
        let record                          = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName]       = "Test"
        record[DDGProfile.kLastName]        = "Testington"
        record[DDGProfile.kCompanyName]     = "Best Company Ever"
        record[DDGProfile.kBio]             = "This is my bio. I work for the best company ever. I am the best employee there ever was."
        
        return record
    }
}
