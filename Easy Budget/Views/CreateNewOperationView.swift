import SwiftUI
import SwiftData

struct CreateNewOperationView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @Query var categories: [Category]
    @Query var accounts: [Account]
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @State private var operationName = ""
    @State private var operationSum = 0.0
    @State private var operationDescription = ""
    @State private var repeatOperation = false
    @State private var selectedCategory: Category?
    @State private var selectedAccount: Account?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Main information") {
                    TextField("Transaction name", text: $operationName)
                    HStack {
                        Text("Transaction sum:")
                            .frame(width: 150, alignment: .leading)
                        TextField("", value: $operationSum, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    Toggle("Repeat monthly", isOn: $repeatOperation)
                }
                
                Section("Category and account"){
                    Picker("Select category", selection: $selectedCategory) {
                        ForEach(categories, id: \.id) { category in
                            Text(category.name).tag(category as Category?)
                        }
                    }
                    Picker("Select account", selection: $selectedAccount) {
                        ForEach(accounts, id: \.id) { account in
                            Text(account.name).tag(account as Account?)
                        }
                    }
                }
                Section("Description") {
                    TextEditor(text: $operationDescription)
                        .frame(height: 150)
                }
            }
            .navigationTitle("New transaction")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveOperation()
                    }.disabled(operationSum.isNaN || operationName.isEmpty || selectedAccount == nil)
                }
            }
            .onAppear {
                if let firstCategory = categories.first {
                    selectedCategory = firstCategory
                }
                if let firstAccount = accounts.first {
                    selectedAccount = firstAccount
                }
            }
        }
    }
    
    private func saveOperation() {
        guard let selectedCategory = selectedCategory, let selectedAccount = selectedAccount else {
               return
           }
        
        let newOperation = Operation(
            name: operationName,
            operationSum: operationSum,
            operationDescription: operationDescription,
            categoryId: selectedCategory.id,
            repeatEveryMonth: repeatOperation,
            dateCreated: Date(),
            category: selectedCategory,
            account: selectedAccount
        )
        
        do {
            modelContext.insert(newOperation)
            try modelContext.save()
            dismiss() 
        } catch {
            print("Unresolved error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CreateNewOperationView()
}
