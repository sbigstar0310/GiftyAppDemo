//
//  AddCardView.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/25/24.
//

import SwiftUI
import PhotosUI

struct AddCardView: View {
  @EnvironmentObject var dataModel: DataModel
  @Environment(\.dismiss) private var dismiss
  @State private var brand: String = ""
  @State private var productName: String = ""
  @State private var expDate: Date = Date()
  @State private var barcordNum: String = ""
  @State private var photosPickerItem: PhotosPickerItem?
  @State private var selectedImage: Image? = Image(systemName: "photo")

  var body: some View {
    Form {
      VStack {
        PhotosPicker(selection: $photosPickerItem) {
          Text("이미지 선택하기")
        }
        
        selectedImage!
          .resizable()
          .scaledToFit()
        
      }
      .onChange(of: photosPickerItem) {
        Task {
          if let loaded = try? await photosPickerItem?.loadTransferable(type: Image.self) {
            selectedImage = loaded
            print("selected")
          } else {
            print("Failed")
          }
        }
      }
      
      Section("브랜드") {
        TextField("브랜드명을 입력해주세요.", text: $brand)
        
      }
      Section("상품명") {
        TextField("상품명을 입력해주세요.", text: $productName)
        
      }
      Section("유효기간") {
        Text("\(Date(), formatter: myDateFormatter)")
        DatePicker(
          "",
           selection: $expDate,
           in: Date()...,
          displayedComponents: .date
        )
        .datePickerStyle(.graphical)
        
      }
      Section("바코드") {
        TextField("바코드를 입력해주세요.", text: $barcordNum)
        
      }
    }
    .navigationTitle("추가하기")
    .toolbar {
      ToolbarItem {
        Button("추가하기") {
          dataModel.gifticons.append(Gifticon(name: productName, img: selectedImage, expDate: expDate, brand: brand, barcodeNum: barcordNum))
          dismiss()
        }
      }
    }
  }
}

#Preview {
  AddCardView()
    .environmentObject(DataModel())
}
