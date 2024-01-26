//
//  ContentView.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/7/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var dataModel = DataModel()
  @StateObject private var FBDataModel = FirebaseDataModel()
  
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("홈", systemImage: "house")
        }
        .environmentObject(FBDataModel)
        .environmentObject(dataModel)
    }
  }
}

#Preview {
  ContentView()
}
