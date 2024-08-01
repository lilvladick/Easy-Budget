import SwiftUI
import SwiftData

struct HomeScreenView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("currencySelection") private var currencySelection: String = "US Dollar"
    
    @Query private var accounts: [Account]
    @State private var selectedAccount: Account?
    @State private var showMenu = false
    @State private var showingNewAccount = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HeaderView(selectedAccount: $selectedAccount)
                AccountScrollView(accounts: accounts, selectedAccount: $selectedAccount)
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
                    MenuView(showMenu: $showMenu, showingNewAccount: $showingNewAccount)
                        .padding()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: showMenu),
            alignment: .bottomTrailing
        )
        .preferredColorScheme(isDarkmodeOn ? .dark : .light)
        .sheet(isPresented: $showingNewAccount) {
            CreateNewAccount()
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
                    .font(.system(size: 25))
            }
        }
        .padding()
    }
}

struct AccountScrollView: View {
    let accounts: [Account]
    @Binding var selectedAccount: Account?
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(accounts) { account in
                    AccountCartView(account: account)
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
}

struct MenuView: View {
    @Binding var showMenu: Bool
    @Binding var showingNewAccount: Bool
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            MenuButton(title: "New transaction", showMenu: $showMenu, action: {
                
            })
            MenuButton(title: "New category", showMenu: $showMenu, action: {
                
            })
            MenuButton(title: "New account", showMenu: $showMenu, action: {
                showingNewAccount = true
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
