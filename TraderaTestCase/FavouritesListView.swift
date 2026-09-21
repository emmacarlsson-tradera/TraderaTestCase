import SwiftUI

struct FavouritesListView: View {
    @ObservedObject var viewModel: ProductsViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.favouriteProducts) { product in
                ProductRowView(
                    product: product,
                    isFavourite: viewModel.isFavourite(product),
                    onToggleFavourite: {
                        viewModel.toggleFavourite(for: product)
                    }
                )
            }
            .navigationTitle("Favourites")
        }
    }
}
