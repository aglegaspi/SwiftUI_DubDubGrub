//
//  UIImage+Ext.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 9/23/21.
//

import CloudKit
import UIKit

extension UIImage {
    func convertToCKAsset() -> CKAsset? {
        
        // get apps base document directory url
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document Directory URL came back nil")
            return nil
        }
        
        // append unique identifier for our profile image
        let fileURL = urlPath.appendingPathComponent("selectedAvatarImage")
        
        // write the image data to the location the address points to
        let imageData = jpegData(compressionQuality: 0.25)
        
        // create our CKAsset with fileURL
        
        
        
        return nil
    }
    
}
