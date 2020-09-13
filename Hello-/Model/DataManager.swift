//
//  DataManager.swift
//  Hello?
//
//  Created by Gavin Butler on 07-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import UIKit
import SwiftUI

class DataManager {
    //Test data only for now
    func getPeople() -> [Person] {
        var tempPeople: [Person] = []
        for _ in 1...20 {
            tempPeople.append(Person(id: UUID()))
        }
        return tempPeople
    }
    
    func getPeopleFromDirectory() -> [Person] {
        var people = [Person]()
        if let files = try? FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil) {
            for file in files {
                if let id = UUID(uuidString: file.lastPathComponent) {
                    people.append(Person(id: id))
                }
            }
        }
        print("People Found: \(people)")
        return people
    }
    
    func loadData(for id: UUID) -> Image {
        let filename = getDocumentsDirectory().appendingPathComponent(id.description)
        
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
    
    func saveImage(_ image: UIImage, withId id: UUID) {
        
        let fileURL = getDocumentsDirectory().appendingPathComponent(id.description)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            do {
                try jpegData.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
                print("Image Saved!!!")
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
