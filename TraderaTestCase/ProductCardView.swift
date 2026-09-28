import SwiftUI

// A view that displays a product card with an image, title, price, and a heart button to toggle the favorite status.
//  Tapping the card triggers the onSelect action to view product details.
struct ProductCardView: View {
    let product: Product
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    let onSelect: () -> Void

    var body: some View {
        // The entire card is a button that triggers the onSelect action when tapped, allowing the user to view product details.
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 0) {
                // The product image is displayed in a square aspect ratio, with a background color and rounded corners. 
                // An AsyncImage is used to load the image from the provided URL, showing a placeholder or progress view while loading.
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
                    .font(.subheadline) 
                    .foregroundStyle(Color.traderaGray)
                    .lineLimit(2)
                    .padding(.top, 8)

                Text("\(product.price) kr")
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(Color.traderaInk)
                    .padding(.top, 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        // The heart button is overlaid on top of the product card, aligned to the top right corner. 
        // It toggles the favorite status of the product.
        .overlay(alignment: .topTrailing) {
            Button(action: onToggleFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(isFavorite ? Color.traderaRed : Color.traderaInk)
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(.plain)
            .padding(7)
            .accessibilityLabel(isFavorite ? "Ta bort \(product.title) från bevakade" : "Bevaka \(product.title)")
        }
    }
}
