import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var viewModel: ProductsViewModel
    @State private var selectedProduct: Product?

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(viewModel.favoriteProducts) { product in
                        ProductCardView(
                            product: product,
                            isFavorite: viewModel.isFavorite(product),
                            onToggleFavorite: {
                                viewModel.toggleFavorite(for: product)
                            },
                            onSelect: {
                                selectedProduct = product
                            }
                        )
                    }
                }
                .padding(.horizontal, 14)
                .padding(.top, 8)
            }
            .background(Color.traderaBackground)
            .overlay {
                // Tom lista ska säga vad man gör åt saken, inte bara att den är tom.
                if viewModel.favoriteProducts.isEmpty {
                    ContentUnavailableView(
                        "Inget bevakat än",
                        systemImage: "heart",
                        description: Text("Tryck på hjärtat på en produkt för att spara den här.")
                    )
                }
            }
            .navigationTitle("Bevakade")
            .sheet(item: $selectedProduct) { product in
                ProductDetailView(
                    product: product,
                    isFavorite: viewModel.isFavorite(product),
                    onToggleFavorite: {
                        viewModel.toggleFavorite(for: product)
                    }
                )
                    .presentationDetents([.medium])
                    .presentationBackground(.ultraThinMaterial)
            }

        }
    }
}
