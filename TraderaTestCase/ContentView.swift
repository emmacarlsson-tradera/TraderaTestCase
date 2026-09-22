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
    
    @State private var selectedProduct: Product?

    var body: some View {
        TabView {
            // Displays each product as a row (image, title, price, favorite button).
            NavigationStack {
                List(viewModel.products) { product in
                    ProductRowView(
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
                .navigationTitle("Products")
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
                Label("Products", systemImage: "list.bullet")
            }

            FavoritesListView(viewModel: viewModel)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    ContentView()
}
