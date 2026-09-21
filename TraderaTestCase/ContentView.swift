//
//  ContentView.swift
//  TraderaTestCase
//
//  Created by Emma Karlsson on 2026-09-21.
//

import SwiftUI

struct ContentView: View {
    // The main screen: fetches and displays the product list.
    @StateObject private var viewModel = ProductsViewModel()

    var body: some View {
        TabView {
            // Displays each product as a row (image, title, price, favourite button).
            NavigationStack {
                List(viewModel.products) { product in
                    ProductRowView(
                        product: product,
                        isFavourite: viewModel.isFavourite(product),
                        onToggleFavourite: {
                            viewModel.toggleFavourite(for: product)
                        }
                    )
                }
                .navigationTitle("Products")
                // Fetches the products from the API as soon as the view appears.
                .task {
                    await viewModel.fetchProducts()
                }
            }
            .tabItem {
                Label("Products", systemImage: "list.bullet")
            }

            FavouritesListView(viewModel: viewModel)
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    ContentView()
}
