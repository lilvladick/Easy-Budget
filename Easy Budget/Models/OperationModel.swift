import Foundation
import SwiftData

@Model
final class Operation {
    let id = UUID()
    var name: String
    var operationDescription: String?
    var categoryId: UUID?
    @Relationship(deleteRule: .nullify) var category: Category?
    @Relationship var account: Account
    
    init(name: String, operationDescription: String? = nil, categoryId: UUID? = nil, category: Category? = nil, account: Account) {
        self.name = name
        self.operationDescription = operationDescription
        self.categoryId = categoryId
        self.category = category
        self.account = account
    }
}
