import Foundation
import SwiftData

@Model
final class Coaster {
    var name: String
    var park: String
    var location: String
    var rideCount: Int
    var dateAdded: Date
    @Attribute(.externalStorage) var imageData: Data?
    
    init(name: String, park: String, location: String, rideCount: Int = 1) {
        self.name = name
        self.park = park
        self.location = location
        self.rideCount = rideCount
        self.dateAdded = Date.now
        self.imageData = imageData
    }
}
