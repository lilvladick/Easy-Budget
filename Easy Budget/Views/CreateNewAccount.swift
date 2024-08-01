import SwiftUI
import SwiftData

struct CreateNewAccount: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    private var notificationsManager = NotificationManager()
    @State private var accountName = ""
    @State private var accountCash = 0.0
    @State private var accountColor = "#000000"
    @State private var selectedColor: Color = .black
    
    var body: some View {
        NavigationStack {
            AccountCartView(account: Account(name: accountName, cash: accountCash, color: accountColor))
            
            Form {
                Section("Account information") {
                    TextField("Name", text: $accountName)
                    TextField("Cash", value: $accountCash, formatter: NumberFormatter()) .keyboardType(.numberPad)
                }
                Section("Cart color") {
                    ColorPicker("Account color", selection: $selectedColor)
                        .onChange(of: selectedColor, initial: true) { oldValue, newValue in
                            accountColor = newValue.toHexString()
                        }
                }
            }
            .navigationTitle("Create new account")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        dismiss()
                        saveAccount()
                    }
                }
            }
        }.preferredColorScheme(isDarkmodeOn ? .dark : .light)
    }
    func saveAccount() {
        let newAccount = Account(
            name: accountName,
            cash: accountCash,
            color: accountColor
        )
        
        modelContext.insert(newAccount)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    CreateNewAccount()
}
