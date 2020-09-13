//
//  EntryView.swift
//  Hello?
//
//  Created by Gavin Butler on 12-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI
import CoreGraphics

struct EntryView: View {
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var enteredName: String = ""
    @State private var dataInvalid = false
    @State private var dataInvalidMessage = ""
    let personId: UUID
    @Environment(\.presentationMode) var presentationMode
    
    let dataManager = DataManager()
    
    @State var showImagePicker = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(image == nil ? Color.secondary : Color.white)
                
                if image != nil {
                    image?
                    .resizable()
                    .scaledToFit()
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
            
            VStack(alignment: .leading) {
                Text("Person Id: \(self.personId.description)")
                Text("Enter Name:")
                TextField("Name:", text: $enteredName)
            }
            
            Spacer()
            
            HStack {
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding()
                Spacer()
                Button("Save") {
                    self.saveImage(withId: self.personId)
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
    
    func saveImage(withId id: UUID) {
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
        dataManager.saveImage(image, withId: id)
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(personId: UUID())
    }
}
