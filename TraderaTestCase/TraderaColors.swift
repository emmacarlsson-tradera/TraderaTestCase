import SwiftUI

// Tradera's color palette, with light and dark variants for each color. The colors are defined as static properties on the Color struct,
//  allowing easy access throughout the app.

extension Color {

    static let traderaInk = adaptive(light: 0x121212, dark: 0xF2F2F2)

    static let traderaGray = adaptive(light: 0x575757, dark: 0xA3ADA9)

    static let traderaSurface = adaptive(light: 0xFFFFFF, dark: 0x1B2320)

    static let traderaBackground = adaptive(light: 0xD9E2DF, dark: 0x0E1613)

    static let traderaGreen = adaptive(light: 0x003B29, dark: 0x0C6B4A)

    static let traderaRed = adaptive(light: 0xDA3530, dark: 0xE8514C)

    /// Light and dark versions of a color, automatically chosen based on the current user interface style.
    private static func adaptive(light: UInt32, dark: UInt32) -> Color {
        Color(uiColor: UIColor { traits in
            UIColor(hex: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

private extension UIColor {
    /// Convenience initializer that creates a UIColor from a hex value.
    convenience init(hex: UInt32) {
        self.init(
            red:   CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >>  8) & 0xFF) / 255,
            blue:  CGFloat( hex        & 0xFF) / 255,
            alpha: 1
        )
    }
}
