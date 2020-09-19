//
//  DetailView.swift
//  Hello?
//
//  Created by Gavin Butler on 07-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @State private var showMapSheet = false
    
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
                    .padding()
                Text(person.wrappedName)
                Spacer()
            }
            ZStack {
                image
                    .resizable()
                    .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 5.0)
            .padding(.vertical, 50.0)
            
            Button(action: {
                self.showMapSheet = true
            }) {
                Text("Photo Location")
                .padding(5)
                    .font(.system(size: 22))
            }
            .background(Color.black.opacity(0.85))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            Spacer()
                        
        }
        .sheet(isPresented: $showMapSheet) {
            MapSheet(centreCoordinate: person.coordinate)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let person = FetchRequest<Peep>(entity: Peep.entity(), sortDescriptors: []).wrappedValue.first!
        return DetailView(person: person)
    }
}
