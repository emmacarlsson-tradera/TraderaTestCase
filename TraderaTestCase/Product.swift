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


