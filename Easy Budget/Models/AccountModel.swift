import Foundation
import SwiftData

@Model
final class Account {
    let id = UUID()
    var name: String
    var cash: Double
    var color: String
    @Relationship(deleteRule: .cascade, inverse: \Operation.account) var operations: [Operation]
    
    init(name: String, cash: Double, color: String, operations: [Operation]) {
        self.name = name
        self.cash = cash
        self.color = color
        self.operations = operations
    }
}
