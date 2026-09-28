import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var viewModel: ProductsViewModel
    @State private var selectedProduct: Product?
    @State private var searchText = ""

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    // The favorites that match the search field. An empty search field means all of them.
    private var filteredFavorites: [Product] {
        guard !searchText.isEmpty else { return viewModel.favoriteProducts }
        return viewModel.favoriteProducts.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Bevakningar")
                    .font(.headline)
                    .foregroundStyle(Color.traderaInk)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 14)
                    .accessibilityAddTraits(.isHeader)

                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(filteredFavorites) { product in
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
                // If there are no favorites, show a message. If there are favorites but none match the search, show a different message.
                if viewModel.favoriteProducts.isEmpty {
                    ContentUnavailableView(
                        "Inget bevakat än",
                        systemImage: "heart",
                        description: Text("Tryck på hjärtat på en produkt för att spara den här.")
                    )
                } else if filteredFavorites.isEmpty {
                    // There are favorites, but none match the search.
                    ContentUnavailableView.search(text: searchText)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Sök bland bevakningar"
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 10) {
                        TraderaLogo()
                        Divider()
                            .frame(width: 300)
                    }
                    .padding(.bottom, 10)
                }
            }
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
