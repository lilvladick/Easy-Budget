import SwiftUI
import SwiftData

let defaults = UserDefaults.standard
let isFirstLaunch = "isFirstLaunch"

@main
struct Easy_BudgetApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Account.self, Operation.self, Category.self)
        } catch {
            fatalError("Initialize error: $$error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            if defaults.bool(forKey: isFirstLaunch) == false {
                FirstLaunchSettingsView()
                    .modelContainer(container)
                    .onAppear {
                        defaults.set(true, forKey: isFirstLaunch)
                    }
            } else {
                HomeScreenView()
                    .modelContainer(container)
            }
        }
    }
}
