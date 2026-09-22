import SwiftUI

struct ProductRowView: View {
    let product: Product
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    let onSelect: () -> Void


    var body: some View {
        HStack {
            // The tappable part that opens the product detail sheet.
            Button(action: onSelect) {
                HStack {
                    // Loads the product image and handles all states: loading, success, and images that fail to load.
                    AsyncImage(url: URL(string: product.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(product.title)
                        Text("\(product.price) \(product.currency)")
                    }
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button(action: onToggleFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")

        }
    }
}

