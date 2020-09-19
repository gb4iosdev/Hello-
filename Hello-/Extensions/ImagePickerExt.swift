//
//  ImagePickerExt.swift
//  Hello-
//
//  Created by Gavin Butler on 19-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

extension UIImagePickerController.SourceType {
    var formattedSourceType: String {
        switch self {
        case .camera: return "Camera"
        case .photoLibrary: return "Photo Library"
        case .savedPhotosAlbum: return "Saved Photo Albums"
        default: return "Unknown"
        }
    }
    
    var formattedMessage: String {
        switch self {
        case .camera: return "Tap to take a photo"
        case .photoLibrary: return "Tap to select a picture"
        case .savedPhotosAlbum: return "Tap to select from a saved Album"
        default: return "What Message to Use?"
        }
    }
}

