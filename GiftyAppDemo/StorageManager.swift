import SwiftUI
import FirebaseStorage

class StorageManager: ObservableObject {
    let storage = Storage.storage()
    
    func upload(image: Data?) {
        // Create a storage reference
        let storageRef = storage.reference().child("images/image.jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = image {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
    
    func listAllFiles() {
        let storageRef = storage.reference().child("images")
        
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error while listing all files: ", error)
            }
            
            for item in result!.items {
                print("Item in images folder: ", item)
            }
        }
    }
    
    func listItem() {
        // Create a reference
        let storageRef = storage.reference().child("images")
        
        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (StorageListResult, Error?) -> Void = { (result, error) in
            if let error = error {
                print("error", error)
            }
            
            let item = result.items
            print("item: ", item) // Returns an array of items
        }
        
        // List the items
        storageRef.list(maxResults: 1) { (result, error) in
            if let error = error {
                print("error", error)
            }
            
            let item = result!.items
            print("item: ", item) // Returns an array of items
        }
    }
    
    func deleteItem(item: StorageReference) {
            item.delete { error in
                if let error = error {
                        print("Error deleting item", error)
                }
            }
    }
}
