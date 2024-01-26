import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class CarStore: ObservableObject {
    @Published var cars: [Car] = []
    @Published var changeCount: Int = 0
    
    let ref: DatabaseReference? = Database.database().reference() // (1)
    
    private let encoder = JSONEncoder() // (2)
    private let decoder = JSONDecoder() // (2)
    
    func listenToRealtimeDatabase() {
        
        guard let databasePath = ref?.child("cars") else {
            return
        }
        
        databasePath
            .observe(.childAdded) { [weak self] snapshot, _ in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else {
                    return
                }
                do {
                    let carData = try JSONSerialization.data(withJSONObject: json)
                    let car = try self.decoder.decode(Car.self, from: carData)
                    self.cars.append(car)
                } catch {
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.childChanged){[weak self] snapshot, _ in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let carData = try JSONSerialization.data(withJSONObject: json)
                    let car = try self.decoder.decode(Car.self, from: carData)
                    
                    var index = 0
                    for carItem in self.cars {
                        if (car.id == carItem.id){
                            break
                        }else{
                            index += 1
                        }
                    }
                    self.cars[index] = car
                } catch{
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.childRemoved){[weak self] snapshot in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let carData = try JSONSerialization.data(withJSONObject: json)
                    let car = try self.decoder.decode(Car.self, from: carData)
                    for (index, carItem) in self.cars.enumerated() where car.id == carItem.id {
                        self.cars.remove(at: index)
                    }
                } catch{
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.value){[weak self] snapshot in
                guard
                    let self = self
                else {
                    return
                }
                self.changeCount += 1
            }
    }
    
    func stopListening() {
        ref?.removeAllObservers()
    }
    
    func addNewCar(car: Car) {
        self.ref?.child("cars").child("\(car.id)").setValue([
            "id": car.id,
            "name": car.name,
            "description": car.description,
            "isHybrid": car.isHybrid
        ])
    }
    
    func deleteCar(key: String) {
        ref?.child("cars/\(key)").removeValue()
    }
    
    func editCar(car: Car) {
        let updates: [String : Any] = [
            "id": car.id,
            "name": car.name,
            "description": car.description,
            "isHybrid": car.isHybrid
        ]
        
        let childUpdates = ["cars/\(car.id)": updates]
        for (index, carItem) in cars.enumerated() where carItem.id == car.id {
            cars[index] = car
        }
        self.ref?.updateChildValues(childUpdates)
    }
}
