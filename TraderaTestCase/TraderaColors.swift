import SwiftUI

// Traderas färger, hämtade från tradera.com.
extension Color {
    /// Nästan svart. Rubriker och priser. #121212
    static let traderaInk = Color(red: 0.071, green: 0.071, blue: 0.071)

    /// Dämpad grå. Sekundär text. #575757
    static let traderaGray = Color(red: 0.341, green: 0.341, blue: 0.341)

    /// Traderas gröna. Köpknappar och annat som bekräftar. #003B29
    static let traderaGreen = Color(red: 0.0, green: 0.231, blue: 0.161)

    /// Traderas röda. Används sparsamt, bara som accent. #DA3530
    static let traderaRed = Color(red: 0.855, green: 0.208, blue: 0.188)

    /// Ljus bakgrund bakom korten. #F7F7F7
    static let traderaBackground = Color(red: 0.969, green: 0.969, blue: 0.969)
}
