import SwiftUI

// Traderas färger, hämtade från tradera.com.
//
// Varje färg finns i två versioner: en för ljust läge och en för mörkt.
// iOS väljer själv vilken som gäller och byter direkt när användaren
// ändrar inställning — vyerna behöver inte veta något om det.
extension Color {

    /// Rubriker och priser. Nästan svart i ljust läge, nästan vitt i mörkt.
    static let traderaInk = adaptive(light: 0x121212, dark: 0xF2F2F2)

    /// Sekundär text, till exempel produkttitlarna i rutnätet.
    static let traderaGray = adaptive(light: 0x575757, dark: 0xA3ADA9)

    /// Ytan som korten ligger på, alltså brickan bakom omslagsbilden.
    static let traderaSurface = adaptive(light: 0xFFFFFF, dark: 0x1B2320)

    /// Bakgrunden bakom korten. Traderagrönt uttunnat mot vitt respektive svart.
    static let traderaBackground = adaptive(light: 0xD9E2DF, dark: 0x0E1613)

    /// Köpknappar. Det mörkgröna försvinner mot mörk bakgrund, så det ljusnar.
    static let traderaGreen = adaptive(light: 0x003B29, dark: 0x0C6B4A)

    /// Accent, används bara på ifyllda hjärtan.
    static let traderaRed = adaptive(light: 0xDA3530, dark: 0xE8514C)

    /// Bygger en färg som byter värde när systemet byter läge.
    private static func adaptive(light: UInt32, dark: UInt32) -> Color {
        Color(uiColor: UIColor { traits in
            UIColor(hex: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

private extension UIColor {
    /// Låter färgerna ovan skrivas som hexkoder i stället för decimaltal.
    convenience init(hex: UInt32) {
        self.init(
            red:   CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >>  8) & 0xFF) / 255,
            blue:  CGFloat( hex        & 0xFF) / 255,
            alpha: 1
        )
    }
}
