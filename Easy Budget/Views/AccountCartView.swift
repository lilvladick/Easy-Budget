import SwiftUI
import SwiftData

struct AccountCartView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("currencySelection") private var currencySelection: String = "US Dollar"
    let account: Account
    
    var body: some View {
        VStack{
            Text(String(format: "%.2f", account.cash) + " \(currencySelection)").font(.largeTitle).bold().foregroundStyle(Color.white)
            HStack {
                //
            }
        }
        .frame(minWidth: 350, minHeight: 200)
        .background(colorFromString(account.color))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    AccountCartView(account: Account(name: "Beta Bank", cash: 123.31, color: ".red"))
}
