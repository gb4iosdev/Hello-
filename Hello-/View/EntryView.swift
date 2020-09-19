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
    @State private var selectedPhotoPickerSourceType = 0
    
    let pickerSourceTypes: [UIImagePickerController.SourceType] = [.camera, .photoLibrary]
    
    let context: NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    let dataManager = DataManager()
    @ObservedObject var locationFetcher = LocationFetcher()
    
    @State var showImagePicker = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Enter Name:")
                    .padding()
                    .font(.headline)
                TextField("Name:", text: $enteredName)
                .padding()
            }
            
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
                    Text(pickerSourceTypes[selectedPhotoPickerSourceType].formattedMessage)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .padding(.horizontal, 5.0)
            .padding(.top, 20.0)
            .padding(.bottom, 30.0)
            .onTapGesture {
                self.showImagePicker = true
            }
            
            Picker("Source Type", selection: $selectedPhotoPickerSourceType) {
                ForEach(0..<pickerSourceTypes.count) {
                    Text("\(self.pickerSourceTypes[$0].formattedSourceType)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 50.0)
            
            VStack(alignment: .leading) {
                HStack{
                    Text("Latitude:  ")
                        .font(.headline)
                    Text(self.locationFetcher.lastKnownLatitude)
                        .padding()
                    Spacer()
                }
                HStack{
                    Text("Longitude:")
                        .font(.headline)
                    Text(self.locationFetcher.lastKnownLongitude)
                }
            }
            .padding(.bottom, 50.0)
            
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                    .padding(5)
                        .font(.system(size: 22))
                }
                .background(Color.black.opacity(0.85))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.leading, 10.0)
                
                Spacer()
                Button(action: {
                    self.save()
                }) {
                    Text("Save")
                    .padding(5)
                        .font(.system(size: 22))
                }
                .background(Color.black.opacity(0.85))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.trailing, 10.0)
            }
            .padding(.bottom, 25.0)
        }
        .onAppear {
            self.locationFetcher.start()
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, sourceType: pickerSourceTypes[selectedPhotoPickerSourceType])
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
        
        dataManager.save(image, name: self.enteredName, coord: self.locationFetcher.lastKnownLocation, in: self.context)
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EntryView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static var context
    static var previews: some View {
        EntryView(context: context)
    }
}
