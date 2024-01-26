//
//  CardRowView.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/7/24.
//

import SwiftUI

struct CardRowView: View {
  var giftycon: Gifticon
  
  var body: some View {
    let leftDate: Int = getDayLeft(from: giftycon.expDate, to: Date())
    
    ZStack {
      Rectangle()
        .foregroundStyle(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .frame(height: 160)
        
      HStack {
        giftycon.img!
          .resizable()
          .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
          .frame(width: 100, height: 140)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding(.leading, 7)
        //        .border(Color.black)
        
        VStack(alignment: .leading) {
          Text(giftycon.name)
            .font(.title3)
            .fontWeight(.bold)
            .lineLimit(2)
            .padding(.bottom, 10)
          
          Text(leftDate <= 0 ? "만료" : "D - \(leftDate)")
            .font(.subheadline)
            .fontWeight(leftDate <= 3 ? .bold : .medium)
            .foregroundStyle(leftDate <= 3 ? .red : .black)
          
          Text(dottedDateFormatter.string(from: giftycon.expDate))
            .font(.caption2)
            .fontWeight(.ultraLight)
        }
        
        Spacer()
        
        Image(systemName: "ellipsis")
          .font(.title2)
          .padding(.trailing, 10)
      }
    }
  }
  
  func getDayLeft(from: Date, to: Date) -> Int {
    let diffDate = from.timeIntervalSince(to)
    return Int( diffDate / (24 * 60 * 60) + 1)
  }
}

#Preview {
  CardRowView(giftycon: DataModel().gifticons[0])
}
