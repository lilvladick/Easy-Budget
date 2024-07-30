import Foundation

struct Currency: Identifiable {
    let id = UUID()
    var name: String
    var symbol: String
    
    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
    }
}

let Currencies: [Currency] = [
    Currency(name: "US Dollar", symbol: "$"),
    Currency(name: "Euro", symbol: "€"),
    Currency(name: "British Pound", symbol: "£"),
    Currency(name: "Japanese Yen", symbol: "¥"),
    Currency(name: "Chinese Yuan", symbol: "¥"),
    Currency(name: "Russian Ruble", symbol: "₽")
]
