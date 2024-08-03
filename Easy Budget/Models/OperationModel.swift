import Foundation
import SwiftData

@Model
final class Operation {
    let id = UUID()
    var name: String
    var operationSum: Double
    var operationDescription: String?
    var repeatEveryMonth: Bool
    var dateCreated: Date
    @Relationship(deleteRule: .nullify) var category: Category?
    @Relationship var account: Account
    
    init(name: String, operationSum: Double, operationDescription: String? = nil, category: Category? = nil, repeatEveryMonth: Bool, dateCreated: Date = Date(), account: Account) {
        self.name = name
        self.operationSum = operationSum
        self.operationDescription = operationDescription
        self.repeatEveryMonth = repeatEveryMonth
        self.dateCreated = dateCreated
        self.category = category
        self.account = account
    }
    
    var categoryName: String? {
        return category?.name
    }
    
    var categoryColor: String? {
        return category?.color
    }
}
