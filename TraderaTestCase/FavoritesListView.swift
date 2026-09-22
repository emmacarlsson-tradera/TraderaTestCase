import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var viewModel: ProductsViewModel
    @State private var selectedProduct: Product?

    var body: some View {
        NavigationStack {
            List(viewModel.favoriteProducts) { product in
                ProductRowView(
                    product: product,
                    isFavorite: viewModel.isFavorite(product),
                    onToggleFavorite: {
                        viewModel.toggleFavorite(for: product)
                    }
                )
                .onTapGesture {
                    selectedProduct = product
                }

            }
            .navigationTitle("Favorites")
            .sheet(item: $selectedProduct) { product in
                ProductDetailView(product: product)
                    .presentationDetents([.medium])
                    .presentationBackground(.ultraThinMaterial)
                    .presentationCornerRadius(24)
            }

        }
    }
}
