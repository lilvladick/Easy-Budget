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

func addDefaultCategories(to context: ModelContext) {
    let defaultCategories = [
        Category(name: "Food", color: "#FF6F61", icon: "🍎"),
        Category(name: "Transport", color: "#4CAF50", icon: "🚗"),
        Category(name: "Clothing", color: "#9C27B0", icon: "👗")
    ]
    
    for category in defaultCategories {
        context.insert(category)
    }
    
    do {
        try context.save()
    } catch {
        print("Failed to save default categories: \(error)")
    }
}
