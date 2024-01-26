//
//  DetailCardView.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/24/24.
//

import SwiftUI

struct DetailCardView: View {
  @EnvironmentObject var dataModel: DataModel
  var giftyconId: UUID
  
  var body: some View {
    let giftycon = dataModel.getWith(id: giftyconId) ?? Gifticon(name: "a", img: Image(systemName: "photo"), expDate: Date(), brand: "a", barcodeNum: "a")
    
    List {
      ZStack {
        NavigationLink {
          DetailCardImageView(image: giftycon.img!)
        } label: {
          EmptyView()
            .opacity(0.0)
        }
        
        giftycon.img!
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      
      Section {
        Text(giftycon.brand)
      } header: {
        Text("브랜드")
      }
      .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
      
      Section {
        Text(giftycon.name)
      } header: {
        Text("상품명")
      }
      .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
      
      Section {
        Text(myDateFormatter.string(from: giftycon.expDate))
      } header: {
        Text("유효기간")
      }
      .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
      
      Section {
        Text(giftycon.barcodeNum)
      } header: {
        Text("바코드")
      }
      .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
    .navigationTitle("기프티콘 상세")
    .toolbar {
      ToolbarItem {
        NavigationLink {
          ChangeCardView(giftyconId: giftyconId)
            .environmentObject(dataModel)
        } label: {
          Text("수정하기")
            .foregroundStyle(.blue)
        }
      }
    }
  }
}

#Preview {
  DetailCardView(giftyconId: UUID())
    .environmentObject(DataModel())
}
