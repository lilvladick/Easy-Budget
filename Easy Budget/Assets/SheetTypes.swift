import Foundation
import SwiftUI

enum SheetType: Identifiable {
    case newAccount
    case newCategory
    case newTransaction //Operation
    
    var id: Self { self }
    
    @ViewBuilder
    var content: some View {
        switch self {
        case .newAccount:
            CreateNewAccount()
        case .newCategory:
            CreateNewCategoryView()
        case .newTransaction:
            CreateNewOperationView()
        }
    }
}
