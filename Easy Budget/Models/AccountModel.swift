import Foundation
import SwiftUI
import SwiftData

@Model
final class Account {
    let id = UUID()
    var name: String
    var cash: Double
    var color: String
    
    init(name: String, cash: Double, color: String) {
        self.name = name
        self.cash = cash
        self.color = color
    }
}
