import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var viewModel: ProductsViewModel

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
            }
            .navigationTitle("Favorites")
        }
    }
}
