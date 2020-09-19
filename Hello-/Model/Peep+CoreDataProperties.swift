//
//  Peep+CoreDataProperties.swift
//  Hello-
//
//  Created by Gavin Butler on 16-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit


extension Peep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Peep> {
        return NSFetchRequest<Peep>(entityName: "Peep")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var latCoordinate: Double
    @NSManaged public var longCoordinate: Double
    
    var wrappedId: String {
        self.id?.description ?? "Unknown Id"
    }
    
    var wrappedName: String {
        self.name?.description ?? "Unknown Name"
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latCoordinate, longitude: longCoordinate)
    }

}
