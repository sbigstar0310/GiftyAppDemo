//
//  DetailCardImageView.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/25/24.
//

import SwiftUI

struct DetailCardImageView: View {
  var image: Image
  
    var body: some View {
      image
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
  DetailCardImageView(image: DataModel().gifticons[0].img!)
}
