import SwiftUI

// Ett produktkort i rutnätet: bild, hjärta, titel och pris.
struct ProductCardView: View {
    let product: Product
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    let onSelect: () -> Void

    var body: some View {
        // Hela kortet är knappen som öppnar detaljvyn.
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 0) {
                // Kvadratisk vit yta som bilden ligger i, så att alla kort blir lika höga
                // oavsett om omslaget är stående eller liggande.
                Color.traderaSurface
                    .aspectRatio(1, contentMode: .fit)
                    .overlay {
                        AsyncImage(url: URL(string: product.image)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                            case .failure:
                                Image(systemName: "photo")
                                    .font(.title2)
                                    .foregroundStyle(Color.traderaGray)
                            default:
                                ProgressView()
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(product.title)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.traderaGray)
                    .lineLimit(2)
                    .padding(.top, 8)

                Text("\(product.price) kr")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.traderaInk)
                    .padding(.top, 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        // Hjärtat läggs ovanpå som ett syskon till knappen, inte inuti den.
        // Annars konkurrerar de två knapparna om samma tryck.
        .overlay(alignment: .topTrailing) {
            Button(action: onToggleFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(isFavorite ? Color.traderaRed : Color.traderaInk)
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(.plain)
            .padding(7)
            .accessibilityLabel(isFavorite ? "Ta bort från bevakade" : "Bevaka")
        }
    }
}
