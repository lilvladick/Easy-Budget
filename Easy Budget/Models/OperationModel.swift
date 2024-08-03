import Foundation
import SwiftData

@Model
final class Operation {
    let id = UUID()
    var name: String
    var operationSum: Double
    var operationDescription: String?
    var categoryId: UUID?
    var repeatEveryMonth: Bool
    var dateCreated: Date
    @Relationship(deleteRule: .nullify) var category: Category?
    @Relationship var account: Account
    
    init(name: String, operationSum:Double,operationDescription: String? = nil, categoryId: UUID? = nil, repeatEveryMonth: Bool, dateCreated: Date = Date(), category: Category? = nil, account: Account) {
        self.name = name
        self.operationSum = operationSum
        self.operationDescription = operationDescription
        self.categoryId = categoryId
        self.repeatEveryMonth = repeatEveryMonth
        self.dateCreated = dateCreated
        self.category = category
        self.account = account
    }
}
