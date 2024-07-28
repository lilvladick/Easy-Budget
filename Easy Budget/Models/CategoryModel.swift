import Foundation
import SwiftData

@Model
final class Category {
    let id = UUID()
    var name: String
    var color: String
    var icon: String
    @Relationship(inverse: \Operation.category) var operations: [Operation]
    
    
    init(name: String, color: String, icon: String, operations: [Operation]) {
        self.name = name
        self.color = color
        self.icon = icon
        self.operations = operations
    }
}
