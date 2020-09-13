//
//  ContentView.swift
//  Hello?
//
//  Created by Gavin Butler on 07-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Peep.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var peeps: FetchedResults<Peep>
    
    @State private var showDetail = false
    
    let dataManager = DataManager()
    
    var body: some View {
        NavigationView {
            List(peeps) { person in
                NavigationLink(destination: DetailView(person: person)) {
                    self.dataManager.loadImage(for: person)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    Text("\(person.wrappedName)")
                }
            }
            .navigationBarTitle("People", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showDetail = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                    }
                }
            )
        }
        .sheet(isPresented: $showDetail) {
            EntryView(context: self.context)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
