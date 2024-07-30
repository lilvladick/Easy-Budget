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
    Currency(name: "Dollar", symbol: "$"),
    Currency(name: "Euro", symbol: "€"),
    Currency(name: "Pound", symbol: "£"),
    Currency(name: "Yen", symbol: "¥"),
    Currency(name: "Yuan", symbol: "¥"),
    Currency(name: "Ruble", symbol: "₽")
]
