//
//  PhotoPicker.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 9/21/21.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // context is UIViewControllerRepresentable
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        // it's communicating with self
        Coordinator(photoPicker: self)
    }
    
    // communicates from UIKit to SwiftUI
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // code
        }
    }
}
