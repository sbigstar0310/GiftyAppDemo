//
//  DataModel.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/25/24.
//

import Foundation
import SwiftUI

class DataModel: ObservableObject {
  @Published var gifticons: [Gifticon]
  
  init() {
    self.gifticons = [
      Gifticon(name: "스타벅스 카페 아메리카노T", img: Image("기프티콘01"), expDate: Date().addingTimeInterval(60 * 60 * 24 * 7), brand: "스타벅스", barcodeNum: "8272 2827 2733"),
        Gifticon(name: "아이스 카페 아메리카노 T 2잔 + The 촉촉 초콜릿 생크림 케이크", img: Image("기프티콘02"), expDate: Date() + (60 * 60 * 24 * 2), brand: "스타벅스", barcodeNum: "8272 2827 2733"),
        Gifticon(name: "GS25 모바일 상품권 3만원", img: Image("기프티콘03"), expDate: Date() - (60 * 60 * 24 * 1), brand: "GS25", barcodeNum: "8272 2827 2733")
    ]
  }
  func getWith(id: UUID) -> Gifticon? {
    return self.gifticons.first(where: {$0.id == id})
  }
  
  func updateWith(id: UUID, newName: String? = nil, newImg: Image? = nil, newExpDate: Date? = nil, newBrand: String? = nil, newBarcodeNum: String? = nil)  {
    if let index = gifticons.firstIndex(where: {$0.id == id}) {
      if let newName = newName {
        gifticons[index].name = newName
      }
      if let newImg = newImg {
        gifticons[index].img = newImg
      }
      if let newExpDate = newExpDate {
        gifticons[index].expDate = newExpDate
      }
      if let newBrand = newBrand {
        gifticons[index].brand = newBrand
      }
      if let newBarcodeNum = newBarcodeNum {
        gifticons[index].barcodeNum = newBarcodeNum
      }
    }
  }
}

var myDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일"
    return formatter
}

var dottedDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter
}
