import Foundation
import SwiftUI

func colorFromString(_ colorString: String) -> Color {
    switch colorString {
    case ".red": return .red
    case ".blue": return .blue
    case ".green": return .green
    default: return .clear
    }
}
