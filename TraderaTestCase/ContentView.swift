import SwiftUI

struct ContentView: View {
    // The main screen: fetches and displays the product list.
    @StateObject private var viewModel = ProductsViewModel()

    @State private var selectedProduct: Product?
    @State private var searchText = ""

    // Defines a two-column grid layout for displaying products.
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    // Provides a filtered list of products based on the search text.
    private var filteredProducts: [Product] {
        guard !searchText.isEmpty else { return viewModel.products }
        return viewModel.products.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        TabView {
            // Displays each product as a card in a two column grid.
            NavigationStack {
                ScrollView {
                    Text("Produkter")
                        .font(.headline)
                        .foregroundStyle(Color.traderaInk)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 14)
                        .accessibilityAddTraits(.isHeader)

                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(filteredProducts) { product in
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // The Tradera logo is displayed in the navigation bar.
                    ToolbarItem(placement: .principal) {
                        VStack(spacing: 10) {
                            TraderaLogo()
                            Divider()
                                .frame(width: 300)
                        }
                        .padding(.bottom, 10)
                    }
                }
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Sök bland produkter"
                )

                // Fetches the products from the API as soon as the view appears.
                .task {
                    await viewModel.fetchProducts()
                }
                // Shows the tapped product's details in a sheet.
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
            .tabItem {
                Label("Produkter", systemImage: "square.grid.2x2")
            }

            FavoritesListView(viewModel: viewModel)
                .tabItem {
                    Label("Bevakade", systemImage: "heart")
                }
        }
        // Sets the accent color for the tab bar and other interactive elements to Tradera's ink color.
        .tint(Color.traderaInk)
    }
}

#Preview {
    ContentView()
}
