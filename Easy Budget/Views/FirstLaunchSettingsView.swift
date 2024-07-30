import SwiftUI

enum SetupSteps: CaseIterable {
    case welcome
    case languageSelection
    case currencySelection
    case finished
}

struct FirstLaunchSettingsView: View {
    @AppStorage("languageSelection") private var languageSelection: String = "English"
    @AppStorage("currencySelection") private var currencySelection: String = "US Dollar"
    @State private var currentSetupStep = SetupSteps.welcome

    var body: some View {
        NavigationStack {
            switch currentSetupStep {
            case .welcome:
                WelcomeView(onNext: {
                    withAnimation {
                        currentSetupStep = .languageSelection
                    }
                })
            case .languageSelection:
                LanguageSelectionView(
                    onNext: {
                        withAnimation {
                            currentSetupStep = .currencySelection
                        }
                    },
                    languageSelection: $languageSelection
                )
            case .currencySelection:
                CurrencySelectionView(
                    onNext: {
                        withAnimation {
                            currentSetupStep = .finished
                        }
                    },
                    currencySelection: $currencySelection, currencies: Currencies
                )
            case .finished:
                HomeScreenView()
            }
        }
    }
}

struct WelcomeView: View {
    let onNext: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Image("WelcomeImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: geometry.size.width * 0.5)

                Text("Welcome to Easy Budget!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                Text("A simple and effective solution for managing personal finances. Let's start together!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        Button(action: {
            onNext()
        }, label: {
            Text("Next").bold().font(.title3)
        })
        .padding(10)
        .background(Color.black)
        .cornerRadius(15)
        .foregroundColor(Color.white)
    }
}

struct LanguageSelectionView: View {
    let onNext: () -> Void
    @Binding var languageSelection: String

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .font(.system(size: 80))
                .padding()

            Text("Choose Language")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text("Select your preferred language for the app interface.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Picker("Language", selection: $languageSelection) {
                Text("English").tag("English")
                Text("Русский").tag("Русский")
            }
            .pickerStyle(.menu)
            .tint(.black)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        Button("Next") {
            onNext()
        }
        .padding(10)
        .background(Color.black)
        .foregroundColor(Color.white)
        .cornerRadius(15)
    }
}
struct CurrencySelectionView: View {
    let onNext: () -> Void
    @Binding var currencySelection: String
    let currencies: [Currency]
    
    var body: some View {
        VStack {
            Image(systemName: "banknote")
                .font(.system(size: 80))
                .padding()

            Text("Choose Currency")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text("Select your preferred currency for the app.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Picker("Select Currency", selection: $currencySelection) {
                ForEach(currencies) { currency in
                    Text("\(currency.symbol)  \(currency.name)").tag(currency.symbol)
                }
            }
            .pickerStyle(.menu)
            .tint(.black)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        Button(action: {
            onNext()
        }, label: {
            Text("Next").bold().font(.title3)
        })
        .padding(10)
        .background(Color.black)
        .cornerRadius(15)
        .foregroundColor(Color.white)
    }
}

#Preview {
    FirstLaunchSettingsView()
}
