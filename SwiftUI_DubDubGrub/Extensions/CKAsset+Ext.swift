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
        let placeholder = ImageDimension.getPlaceholder(for: dimension)
        
        guard let imageURL = self.fileURL else { return placeholder }
        
        do {
            let data = try Data(contentsOf: imageURL)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
