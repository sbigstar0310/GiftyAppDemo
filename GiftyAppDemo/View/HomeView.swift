//
//  HomeView.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/25/24.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var dataModel: DataModel
  @EnvironmentObject var FBDataModel: FirebaseDataModel
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(dataModel.gifticons) { gifticon in
          ZStack {
            NavigationLink {
              DetailCardView(giftyconId: gifticon.id)
                .environmentObject(dataModel)
            } label: {
              EmptyView()
            }
            .opacity(0.0)
            
            CardRowView(giftycon: gifticon)
          }
        }
        .onDelete(perform: { indexSet in
          dataModel.gifticons.remove(atOffsets: indexSet)
        })
        
        ZStack {
          NavigationLink {
            AddCardView()
              .environmentObject(dataModel)
          } label: {
            EmptyView()
          }
          .opacity(0.0)
          
          ZStack() {
            Capsule()
              .fill(.black)
              .frame(width: 100)
            Text("추가하기")
              .foregroundStyle(.white)
              .shadow(radius: 10)
          }
        }
      }
      .listStyle(.inset)
      .navigationTitle("기프티콘 목록")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  HomeView()
    .environmentObject(DataModel())
    .environment(FirebaseDataModel())
}
