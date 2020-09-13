//
//  DetailView.swift
//  Hello?
//
//  Created by Gavin Butler on 07-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    
    let personId: UUID
    
    let dataManager = DataManager()
    
    private var image: Image {
        dataManager.loadData(for: personId)
    }
    
    @State var showImagePicker = false
    
    var body: some View {
        VStack {
            Text("Name: \(dataManager.nameForPerson(with: personId) ?? "Unknown")")
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
        DetailView(personId: UUID())
    }
}
