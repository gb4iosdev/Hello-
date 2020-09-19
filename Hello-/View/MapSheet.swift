//
//  MapSheet.swift
//  Hello-
//
//  Created by Gavin Butler on 17-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI
import MapKit

struct MapSheet: View {
    let centreCoordinate: CLLocationCoordinate2D
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            MapView(centreCoordinate: centreCoordinate)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "x.circle")
                        .padding(5)
                        .background(Color.black.opacity(0.65))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
            }
        }
    }
}

struct MapSheet_Previews: PreviewProvider {
    static var previews: some View {
        MapSheet(centreCoordinate: CLLocationCoordinate2D())
    }
}
