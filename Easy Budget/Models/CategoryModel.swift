import Foundation
import SwiftData

@Model
final class Category {
    let id = UUID()
    var name: String
    var color: String
    var icon: String
    
    
    init(name: String, color: String, icon: String) {
        self.name = name
        self.color = color
        self.icon = icon
    }
}
