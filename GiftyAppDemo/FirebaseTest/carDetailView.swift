// CarDetailView.swift

import SwiftUI

struct CarDetailView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @ObservedObject var carStore : CarStore
  @State private var isOnEditCarView: Bool = false
  @State var selectedCar: Car
  
  var body: some View {
    Form {
      Section(header: Text("Car Details")) {
        Text(selectedCar.name)
          .font(.headline)
        
        Text(selectedCar.description)
          .font(.body)
        
        HStack {
          Text("Hybrid").font(.headline)
          Spacer()
          Image(systemName: selectedCar.isHybrid ?
                "checkmark.circle" : "xmark.circle" )
        }
        
        Button {
          carStore.deleteCar(key: selectedCar.id)
          self.mode.wrappedValue.dismiss()
        } label: {
          Text("삭제하기")
        }
        
        NavigationLink {
          EditCarView(carStore: carStore, selectedCar: $selectedCar, isOnEditCarView: $isOnEditCarView)
        } label: {
          Text("수정하기")
        }
      }
    }
  }
}

struct CarDetailView_Previews: PreviewProvider {
  static var previews: some View {
    CarDetailView(carStore: CarStore(), selectedCar: Car(id: "", name: "name", description: "des", isHybrid: false))
  }
}
