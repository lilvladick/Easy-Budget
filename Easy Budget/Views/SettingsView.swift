import SwiftUI

struct SettingsView: View {
    var notificationsManager = NotificationManager()
    
    @State private var sentNotify = true {
        didSet {
            if sentNotify == false {
                notificationsManager.disableNotifications()
            }
        }
    }
    @State private var choosedLang = ""
    @State private var iCloudSynIsEnable = false
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("languageSelection") private var languageSelection: String = "English"
    @AppStorage("currencySelection") private var currencySelection: String = "Dollar"
    
    let currencies: [Currency]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("App settings") {
                    Picker("App language", selection: $languageSelection) {
                        Text("English 🇬🇧")
                        Text("Русский 🇷🇺")
                    }
                    Picker("App currency", selection: $currencySelection) {
                        ForEach(currencies) { currency in
                            Text("\(currency.symbol)  \(currency.name)").tag(currency.symbol)
                        }
                    }
                }
                Section("Network") {
                    Toggle("iCloud synchronization", isOn: $iCloudSynIsEnable)
                    Toggle("Notifications", isOn: $sentNotify)
                }
                Section("Design") {
                    Toggle("Dark theme", isOn: $isDarkmodeOn)
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(isDarkmodeOn ? .dark : .light)
    }
}

#Preview {
    SettingsView(currencies: Currencies)
}
