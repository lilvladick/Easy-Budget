import SwiftUI
import SwiftData

struct TransactionListView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @Query var operations: [Operation]
    var body: some View {
        List {
            ForEach(operations, id: \.id) { operation in
                TransactionView(operation: operation)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.white)
        .ignoresSafeArea(edges: [.bottom, .top])
    }
}

#Preview {
    let account = Account(name: "MyAccount", cash: 1000.0, color: "blue")
    let category1 = Category(name: "Food", color: "#FF6F61", icon: "🍎")
    let category2 = Category(name: "Transport", color: "#4CAF50", icon: "🚗")
    
    let container = try! ModelContainer(for: Operation.self)
    let modelContext = container.mainContext
    
    let operations = [
        Operation(
            name: "Dinner",
            operationSum: 360.01,
            operationDescription: "Eggs and coffee",
            category: category1,
            repeatEveryMonth: false,
            dateCreated: Date(),
            account: account 
        ),
        Operation(
            name: "Bus Ticket",
            operationSum: 2.50,
            operationDescription: "Bus fare",
            category: category2,
            repeatEveryMonth: false,
            dateCreated: Date(),
            account: account
        )
    ]
    
    operations.forEach{modelContext.insert($0)}
    
    return TransactionListView().modelContainer(container)
}
