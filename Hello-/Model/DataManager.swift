//
//  DataManager.swift
//  Hello?
//
//  Created by Gavin Butler on 07-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class DataManager {
    
    func loadImage(for person: Peep) -> Image {
        
        guard let personId = person.id else { return Image(systemName: "xmark.octagon") }
        
        let filename = getDocumentsDirectory().appendingPathComponent(personId.description)
        
        do {
            let data = try Data(contentsOf: filename)
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        } catch {
            print("Unable to load saved data.")
        }
        
        return Image(systemName: "xmark.octagon")
    }
    
    func save(_ image: UIImage, name: String, in context: NSManagedObjectContext) {
        
        let person = Peep(context: context)
        person.id = UUID()
        person.name = name
        
        if context.hasChanges {
            try? context.save()
        }
        
        let fileURL = getDocumentsDirectory().appendingPathComponent(person.wrappedId)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            do {
                try jpegData.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save photo.")
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func nameForPerson(with id: UUID) -> String? {
        return id.description
    }
}
