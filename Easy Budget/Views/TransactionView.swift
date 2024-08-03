import SwiftUI
import SwiftData

struct TransactionView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("currencySelection") private var currencySelection: String = "US Dollar"
    let operation: Operation
    
    var body: some View {
        HStack {
            Text("💸").font(.title)
            VStack(alignment: .leading){
                Text(operation.name).font(.title3).bold()
                Text(operation.operationDescription ?? "").font(.callout).foregroundStyle(Color.gray)
            }
            /* preview doesn't work =(
            if let categoryName = operation.categoryName {
                Text(categoryName).font(.headline).foregroundStyle(Color.gray)
            }
            */
            
            Spacer()
            Text(String(format: "%.2f", operation.operationSum) + " \(currencySelection)").font(.title3).bold()
        }
        .background(Color.white)
    }
}

#Preview {
    let account = Account(name: "MyAccount", cash: 1000.0, color: "blue")
    let category = Category(name: "Food", color: "#FF6F61", icon: "🍎")
    let operation = Operation(
        name: "Dinner",
        operationSum: 360.01,
        operationDescription: "Eggs and coffee",
        category: category,
        repeatEveryMonth: false,
        dateCreated: Date(),
        account: account
    )
    
    return TransactionView(operation: operation)
        .previewLayout(.sizeThatFits)
}
