import SwiftUI

// Ordmärket, för navigeringslisten. Ligger i en egen vy så att höjd och
// skärmläsartext bara finns definierade på ett ställe.
struct TraderaLogo: View {
    var height: CGFloat = 26

    var body: some View {
        Image("TraderaLogo")
            .resizable()
            .scaledToFit()
            .frame(height: height)
            .accessibilityLabel("Tradera 2.0")
    }
}
