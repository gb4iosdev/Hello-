//
//  Peep+CoreDataProperties.swift
//  Hello-
//
//  Created by Gavin Butler on 13-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//
//

import Foundation
import CoreData


extension Peep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Peep> {
        return NSFetchRequest<Peep>(entityName: "Peep")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    
    public var wrappedId: String {
        id?.description ?? "Unknown Id"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }

}
