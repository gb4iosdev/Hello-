//
//  EntryView.swift
//  Hello?
//
//  Created by Gavin Butler on 12-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI
import CoreGraphics
import CoreData

struct EntryView: View {
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var enteredName: String = ""
    @State private var dataInvalid = false
    @State private var dataInvalidMessage = ""
    
    let context: NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    let dataManager = DataManager()
    
    @State var showImagePicker = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Enter Name:")
                    .padding()
                TextField("Name:", text: $enteredName)
                .padding()
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .fill(image == nil ? Color.secondary : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                if image != nil {
                    image?
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .padding(.horizontal, 5.0)
            .padding(.vertical, 150.0)
            .onTapGesture {
                self.showImagePicker = true
            }
            
            Spacer()
            
            HStack {
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding()
                Spacer()
                Button("Save") {
                    self.save()
                }
                .padding()
            }
            
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        .alert(isPresented: $dataInvalid) {
            Alert(title: Text("Data Missing"), message: Text(dataInvalidMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func loadImage() {
                guard let inputImage = inputImage else { return }
                image = Image(uiImage: inputImage)
    }
    
    func save() {
        
        guard let image = inputImage else {
            dataInvalidMessage = "Please select a photo"
            dataInvalid = true
            return
        }
        guard enteredName != "" else {
            dataInvalidMessage = "Please enter a name"
            dataInvalid = true
            return
        }
        
        dataManager.save(image, name: self.enteredName, in: self.context)
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EntryView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static var context
    static var previews: some View {
        EntryView(context: context)
    }
}
