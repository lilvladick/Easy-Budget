import SwiftUI
import SwiftData

struct HomeScreenView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("currencySelection") private var currencySelection: String = "US Dollar"
    @Query private var accounts: [Account]
    @State private var selectedAccount: Account?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(selectedAccount?.name ?? "Create your first account")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 25))
                })
            }
            .padding()

            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(accounts) { account in
                        AccountCartView(account: account)
                            .containerRelativeFrame(.horizontal)
                            .onTapGesture {
                                selectedAccount = account
                            }
                            .scaleEffect(account == selectedAccount ? 1.05 : 1)
                    }
                }
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            if let firstAccount = accounts.first {
                selectedAccount = firstAccount
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Account.self)
    let modelContext = container.mainContext
    let accounts = [
        //Account(name: "Beta Bank", cash: 24.25, color: ".red"),
    ]
    
    //accounts.forEach { modelContext.insert($0) }
    
    return HomeScreenView().modelContainer(container)
}
