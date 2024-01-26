// EditCarView.swift

import SwiftUI

struct EditCarView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @ObservedObject var carStore : CarStore
  @State var isHybrid = false
  @State var name: String = ""
  @State var description: String = ""
  @Binding var selectedCar: Car
  @Binding var isOnEditCarView: Bool
  
  var body: some View {
    VStack {
      DataInput(title: "Name", userInput: $selectedCar.name)
      DataInput(title: "Description", userInput: $selectedCar.description)
      
      Toggle(isOn: $selectedCar.isHybrid) {
        Text("Hybrid").font(.headline)
      }.padding()
      
      Button  {
        let editCar = Car(
          id: selectedCar.id,
          name: selectedCar.name,
          description: selectedCar.description,
          isHybrid: selectedCar.isHybrid
        )
        carStore.editCar(car: editCar)
        self.mode.wrappedValue.dismiss()
        isOnEditCarView.toggle()
      } label: {
        Text("확인")
      }
    }
  }
}


struct EditCarView_Previews: PreviewProvider {
  static var previews: some View {
    EditCarView(carStore: CarStore(), selectedCar: .constant(Car(id: "", name: "name", description: "des", isHybrid: false)), isOnEditCarView: .constant(true))
  }
}
