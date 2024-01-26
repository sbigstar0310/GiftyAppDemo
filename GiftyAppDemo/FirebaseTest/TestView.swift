import SwiftUI

struct TestView: View {
  @StateObject var carStore: CarStore = CarStore()
  
  var body: some View {
    NavigationStack {
      VStack{
        Text("데이터베이스 변경사항: \(carStore.changeCount)")
        List {
          ForEach(carStore.cars, id: \.self) { car in
            NavigationLink {
              CarDetailView(carStore: carStore, selectedCar: car)
            } label: {
              ListCell(car: car)
            }
          }
        }
        .navigationBarTitle(Text("EV Cars"))
        .toolbar {
          ToolbarItem {
            NavigationLink {
              AddNewCarView(carStore: carStore)
            } label: {
              Text("추가")
            }
          }
        }
      }
    }.onAppear {
      carStore.listenToRealtimeDatabase()
    }
    .onDisappear {
      carStore.stopListening()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}

struct ListCell: View {
  var car: Car
  
  var body: some View {
    HStack {
      Text(car.name)
    }
  }
}
