//
//  TraderaTestCaseTests.swift
//  TraderaTestCaseTests
//
//  Created by Emma Carlsson on 2026-09-28.
//

import Foundation
import Testing
@testable import TraderaTestCase

@MainActor
struct ProductsViewModelTests {

    let product = Product(id: 1, title: "Mega Man 2", price: 129, currency: "SEK", image: "")
    let otherProduct = Product(id: 2, title: "Pirates", price: 89, currency: "SEK", image: "")

    // Runs before every test, so each test starts without any saved favorites.
    init() {
        UserDefaults.standard.removeObject(forKey: "favoriteIDs")
    }

    @Test func toggleFavoriteAddsAndRemoves() {
        let viewModel = ProductsViewModel()

        viewModel.toggleFavorite(for: product)
        #expect(viewModel.isFavorite(product))

        viewModel.toggleFavorite(for: product)
        #expect(!viewModel.isFavorite(product))
    }

    @Test func favoriteProductsOnlyContainsFavorites() {
        let viewModel = ProductsViewModel()
        viewModel.products = [product, otherProduct]

        viewModel.toggleFavorite(for: product)

        #expect(viewModel.favoriteProducts.map(\.id) == [product.id])
    }
}

