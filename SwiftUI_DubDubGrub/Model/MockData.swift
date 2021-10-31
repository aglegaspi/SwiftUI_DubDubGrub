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
    
    static var chipotle: CKRecord {
            let record                          = CKRecord(recordType: RecordType.location,
                                                           recordID: CKRecord.ID(recordName: "87A6D317-FEC1-4A81-D141-71BF4117D01A"))
            record[DDGLocation.kName]           = "Chipotle"
            record[DDGLocation.kAddress]        = "1 S Market St Ste 40"
            record[DDGLocation.kDescription]    = "Our local San Jose One South Market Chipotle Mexican Grill is cultivating a better world by serving responsibly sourced, classically-cooked, real food."
            record[DDGLocation.kWebsiteURL]     = "https://locations.chipotle.com/ca/san-jose/1-s-market-st"
            record[DDGLocation.kLocation]       = CLLocation(latitude: 37.334967, longitude: -121.892566)
            record[DDGLocation.kPhoneNumber]    = "408-938-0919"
            
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
