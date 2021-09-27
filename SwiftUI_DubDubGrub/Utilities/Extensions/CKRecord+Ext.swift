//
//  CKRecord+Ext.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 9/26/21.
//

import CloudKit

extension CKRecord {
    func convertToDDGLocation() -> DDGLocation { DDGLocation(record: self) }
    func convertToDDGProfile() -> DDGProfile { DDGProfile(record: self) }
}
