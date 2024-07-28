import SwiftUI

enum SetupSteps: CaseIterable {
    case welcome
    case languageSelection
    case currencySelection
    case themeSelection
    case finished
}

struct FirstLaunchSettingsView: View {
    @AppStorage("languageSelection") private var languageSelection: String = "English"
    @AppStorage("currencySelection") private var currencySelection: String = "dollar"
    @AppStorage("themeSelection") private var themeSelection: String = "light"

    @State private var currentSetupStep = SetupSteps.languageSelection

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
                            currentSetupStep = .themeSelection
                        }
                    },
                    currencySelection: $currencySelection
                )
            case .themeSelection:
                ThemeSelectionView(
                    onNext: {
                        withAnimation {
                            currentSetupStep = .finished
                        }
                    },
                    themeSelection: $themeSelection
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
        }).padding(10).background(.black).cornerRadius(10).foregroundColor(.white)
    }
}

struct LanguageSelectionView: View {
    let onNext: () -> Void
    @Binding var languageSelection: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("🌎").font(.system(size: geometry.size.width * 0.4))
                Text("Let's choose language")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                Text("To make using the application as comfortable as possible, we suggest you choose the interface language.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Picker("Select language", selection: $languageSelection) {
                    Text("English").tag("English")
                    Text("Русский").tag("Русский")
                }.pickerStyle(.menu).tint(.black)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        Button(action: {
            onNext()
        }, label: {
            Text("Next").bold().font(.title3)
        }).padding(10).background(.black).cornerRadius(10).foregroundColor(.white)
    }
}

struct CurrencySelectionView: View {
    let onNext: () -> Void
    @Binding var currencySelection: String
    var body: some View {
        Text("cur")
        
        Button(action: {
            onNext()
        }, label: {
            Text("Next").bold().font(.title3)
        }).padding(10).background(.black).cornerRadius(10).foregroundColor(.white)
    }
}

struct ThemeSelectionView: View {
    let onNext: () -> Void
    @Binding var themeSelection: String
    var body: some View {
        Text("theme")
        
        Button(action: {
            onNext()
        }, label: {
            Text("Next").bold().font(.title3)
        }).padding(10).background(.black).cornerRadius(10).foregroundColor(.white)
    }
}

#Preview {
    FirstLaunchSettingsView()
}
