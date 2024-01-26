import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class FirebaseDataModel: ObservableObject {
    @Published var gifticons: [Gifticon] = []
    @Published var changeCount: Int = 0
    
    let ref: DatabaseReference? = Database.database().reference() // (1)
    
    private let encoder = JSONEncoder() // (2)
    private let decoder = JSONDecoder() // (2)
    
    func listenToRealtimeDatabase() {
        guard let databasePath = ref?.child("gifticons") else {
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
                    let gifticonData = try JSONSerialization.data(withJSONObject: json)
                    let gifticon = try self.decoder.decode(Gifticon.self, from: gifticonData)
                    self.gifticons.append(gifticon)
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
                    let gifticonData = try JSONSerialization.data(withJSONObject: json)
                    let gifticon = try self.decoder.decode(Gifticon.self, from: gifticonData)
                    
                    var index = 0
                    for gifticonItem in self.gifticons {
                        if (gifticon.id == gifticonItem.id){
                            break
                        }else{
                            index += 1
                        }
                    }
                    self.gifticons[index] = gifticon
                } catch{
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.childRemoved) {[weak self] snapshot in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let gifticonData = try JSONSerialization.data(withJSONObject: json)
                    let gifticon = try self.decoder.decode(Gifticon.self, from: gifticonData)
                    for (index, gifticonItem) in self.gifticons.enumerated() where gifticon.id == gifticonItem.id {
                        self.gifticons.remove(at: index)
                    }
                } catch{
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.value){ [weak self] snapshot in
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
    
    func addNewGifticon(gifticon: Gifticon) {
        self.ref?.child("gifticons").child("\(gifticon.id)").setValue([
          "id" : gifticon.id,
          "productName" : gifticon.productName,
          "imgName" : gifticon.imgName,
          "expDate" : gifticon.expDate,
          "brandName" : gifticon.brandName,
          "barcodeNum" : gifticon.barcodeNum,
        ])
    }
    
    func deleteGifticon(key: String) {
        ref?.child("gifticons/\(key)").removeValue()
    }
    
    func editGifticon(gifticon: Gifticon) {
        let updates: [String : Any] = [
          "id" : gifticon.id,
          "productName" : gifticon.productName,
          "imgName" : gifticon.imgName,
          "expDate" : gifticon.expDate,
          "brandName" : gifticon.brandName,
          "barcodeNum" : gifticon.barcodeNum,
        ]
        
        let childUpdates = ["gifticons/\(gifticon.id)": updates]
        for (index, gifticonItem) in gifticons.enumerated() where gifticonItem.id == gifticon.id {
            gifticons[index] = gifticon
        }
        self.ref?.updateChildValues(childUpdates)
    }
}
