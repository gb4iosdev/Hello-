//
//  ContentView.swift
//  Hello?
//
//  Created by Gavin Butler on 07-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showDetail = false
    
    let dataManager = DataManager()
    var peeps: [Person] {
        dataManager.getPeopleFromDirectory()
    }
    
    var body: some View {
        NavigationView {
            List(peeps) { person in
                NavigationLink(destination: DetailView(personId: person.id)) {
                    Text("\(person.name)")
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
            EntryView(personId: UUID())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
