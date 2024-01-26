//
//  AddCardView.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/25/24.
//

import SwiftUI
import PhotosUI

struct ChangeCardView: View {
  @EnvironmentObject var dataModel: DataModel
  @Environment(\.dismiss) private var dismiss
  @State private var photosPickerItem: PhotosPickerItem?
  var giftyconId: UUID
  
  var body: some View {
    let index = dataModel.gifticons.firstIndex {$0.id == giftyconId} ?? 0
    
    Form {
      VStack {
        dataModel.gifticons[index].img!
          .resizable()
          .scaledToFit()
        
        PhotosPicker(selection: $photosPickerItem) {
          Label("이미지 변경", systemImage: "photo.fill.on.rectangle.fill")
        }
        .photosPickerStyle(.presentation)
      }
      .onChange(of: photosPickerItem) {
        Task {
          if let loaded = try? await photosPickerItem?.loadTransferable(type: Image.self) {
            dataModel.gifticons[index].img = loaded
          } else {
          }
        }
      }
      
      Section("브랜드") {
        TextField("브랜드명을 입력해주세요.", text: $dataModel.gifticons[index].brand)
      }
      
      Section("상품명") {
        TextField("상품명을 입력해주세요.", text: $dataModel.gifticons[index].name)
      }
      
      Section("유효기간") {
        Text("\(dataModel.gifticons[index].expDate, formatter: myDateFormatter)")
        DatePicker(
          "",
          selection: $dataModel.gifticons[index].expDate,
          in: Date()...,
          displayedComponents: .date
        )
        .datePickerStyle(.graphical)
      }
      
      Section("바코드") {
        TextField("바코드를 입력해주세요.", text: $dataModel.gifticons[index].barcodeNum)
        
      }
    }
    .navigationTitle("수정하기")
    .toolbar {
      ToolbarItem {
        Button("수정 완료") {
          dismiss()
        }
      }
    }
  }
}

#Preview {
  ChangeCardView(giftyconId: DataModel().gifticons[0].id)
    .environmentObject(DataModel())
}
