//
//  Product.swift
//  TraderaTestCase
//
//  Created by Emma Karlsson on 2026-09-21.
//

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Int
    let currency: String
    let image: String
}

struct ProductFeed: Codable {
    let products: [Product]
}


