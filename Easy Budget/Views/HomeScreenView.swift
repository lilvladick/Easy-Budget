import SwiftUI
import SwiftData

struct HomeScreenView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("currencySelection") private var currencySelection: String = "US Dollar"
    
    @Query private var accounts: [Account]
    @State private var selectedAccount: Account?
    @State private var showMenu = false
    @State private var sheetType: SheetType? = nil

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HeaderView(selectedAccount: $selectedAccount)
                AccountScrollView(accounts: accounts, selectedAccount: $selectedAccount)
                    .frame(maxWidth: .infinity, maxHeight: 150)
                TransactionListView()
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea(edges: [.bottom, .top])
                Spacer()
            }
            .onAppear {
                if let firstAccount = accounts.first {
                    selectedAccount = firstAccount
                }
            }
        }
        .overlay(
            VStack {
                Spacer()
                if !showMenu {
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Circle().fill(Color.accentColor))
                    }
                    .padding(.horizontal)
                }
                
                if showMenu {
                    MenuView(showMenu: $showMenu, sheetType: $sheetType)
                        .padding()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: showMenu),
            alignment: .bottomTrailing
        )
        .preferredColorScheme(isDarkmodeOn ? .dark : .light)
        .sheet(item: $sheetType) { sheetType in
            sheetType.content
        }
    }
}

struct HeaderView: View {
    @Binding var selectedAccount: Account?
    
    var body: some View {
        HStack {
            Text(selectedAccount?.name ?? "Create your first account")
                .font(.largeTitle)
                .bold()
            Spacer()
            NavigationLink {
                SettingsView(currencies: Currencies)
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20))
            }
        }
        .padding()
    }
}

struct AccountScrollView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @State var accounts: [Account]
    @Binding var selectedAccount: Account?
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(accounts) { account in
                    AccountCartView(account: account, onDelete: deleteAccount)
                        .contentShape(Rectangle())
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
    
    private func deleteAccount(account: Account) {
        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
           accounts.remove(at: index)
           modelContext.delete(account)
           do {
               try modelContext.save()
           } catch {
               print("Failed to delete account: \(error.localizedDescription)")
           }
       }
    }
}

struct MenuView: View {
    @Binding var showMenu: Bool
    @Binding var sheetType: SheetType?
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            MenuButton(title: "New transaction", showMenu: $showMenu, action: {
                sheetType = .newTransaction
            })
            MenuButton(title: "New category", showMenu: $showMenu, action: {
                sheetType = .newCategory
            })
            MenuButton(title: "New account", showMenu: $showMenu, action: {
                sheetType = .newAccount
            })
        }
        .background(isDarkmodeOn ? Color.menuColors : Color.white)
        .foregroundColor(isDarkmodeOn ? Color.white : Color.black)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}


struct MenuButton: View {
    let title: String
    @Binding var showMenu: Bool
    let action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
            showMenu = false
        }) {
            Text(title)
                .padding()
                .background(Color.clear)
                .cornerRadius(10)
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
