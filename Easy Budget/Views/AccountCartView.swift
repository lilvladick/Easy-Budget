import SwiftUI
import SwiftData

struct AccountCartView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("currencySelection") private var currencySelection: String = "US Dollar"
    let account: Account
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Spacer()
                Text("Current balance:")
                    .font(.callout)
                Text(String(format: "%.2f", account.cash) + " \(currencySelection)")
                    .font(.largeTitle)
                    .bold()
            }
            .padding()
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .overlay {
            Circle()
                .fill(Color.white.opacity(0.25))
                .scaleEffect(3, anchor: .topTrailing)
                .offset(x:-50, y:-40)
        }
        .background(Color(account.color) ?? .clear)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(Color.white)
        .padding(.horizontal)
    }
}

#Preview {
    AccountCartView(account: Account(name: "Beta Bank", cash: 123.31, color: "#FF3535"))
}
