//
//  CKAsset+Ext.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 9/2/21.
//

import CloudKit
import UIKit

extension CKAsset {
    
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        
        guard let imageURL = self.fileURL else { return dimension.placeholder }
        
        do {
            let data = try Data(contentsOf: imageURL)
            return UIImage(data: data) ?? dimension.placeholder
        } catch {
            return dimension.placeholder
        }
    } //convertToUIImage
    
}
