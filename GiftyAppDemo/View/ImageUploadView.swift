//
//  ContentView.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/7/24.
//

import SwiftUI
import PhotosUI

struct ImageUploadView: View {
    var storageManager = StorageManager()
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            Text("Select a photo")
        }
        .onChange(of: selectedItem) { oldValue, newValue in
            if let newValue = newValue {
                Task {
                    let data = try await newValue.loadTransferable(type: Data.self)
                    storageManager.upload(image: data)
                    print("Success!")
                }
            }
        }
    }
}

#Preview {
    ImageUploadView()
}
