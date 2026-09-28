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
    @State private var searchText = ""

    // Två lika breda kolumner med 12 punkters mellanrum.
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    // Produkterna som matchar sökfältet. Tomt sökfält betyder alla.
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
                    // Loggan visas i navigeringslisten, ovanför rubriken.
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
        // Ersätter iOS-blå i markerad flik och sökfält med Traderas nästan-svarta.
        .tint(Color.traderaInk)
    }
}

#Preview {
    ContentView()
}
