//
//  DetailView.swift
//  Hello?
//
//  Created by Gavin Butler on 07-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    
    let person: Peep
    
    let dataManager = DataManager()
    
    private var image: Image {
        dataManager.loadImage(for: person)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Name:  ")
                    .font(.headline)
                Text(person.wrappedName)
            }
            ZStack {
                image
                    .resizable()
                    .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 5.0)
            .padding(.vertical, 150.0)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let person = FetchRequest<Peep>(entity: Peep.entity(), sortDescriptors: []).wrappedValue.first!
        return DetailView(person: person)
    }
}
