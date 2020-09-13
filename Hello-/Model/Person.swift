//
//  Person.swift
//  Hello?
//
//  Created by Gavin Butler on 07-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import Foundation

struct Person: Identifiable {
    let id: UUID
    let name: String
    
    init(id: UUID) {
        self.id = id
        self.name = id.description
    }
}
