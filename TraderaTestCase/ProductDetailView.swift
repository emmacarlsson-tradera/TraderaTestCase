import SwiftUI

struct ProductDetailView: View {
    let product: Product
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: product.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 200, height: 200)

                Text(product.title)
                    .font(.title2)
                    .bold()

                Text("\(product.price) kr")
                    .font(.title3)

                Button(action: {}) {
                    Text("Köp nu")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.traderaGreen)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: onToggleFavorite) {
                    HStack {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(isFavorite ? Color.traderaRed : Color.traderaInk)
                        Text(isFavorite ? "Ta bort från bevakade" : "Bevaka")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.traderaGray.opacity(0.4), lineWidth: 1)
                    )
                }
                .padding(.horizontal)
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)

            Button(action: { dismiss() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.traderaGray)
            }
            .accessibilityLabel("Stäng")
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
        .presentationDragIndicator(.hidden)
    }
}
