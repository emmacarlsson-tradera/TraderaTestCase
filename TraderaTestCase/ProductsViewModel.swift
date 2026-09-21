import Foundation
import Combine

// ViewModel that fetches products from Tradera and keeps track of whether or not they have been marked as favorite.
@MainActor
class ProductsViewModel: ObservableObject {
    
    // Listan med alla produkter, hämtad från API:et.
    //A list of all the products, fetched from the API.
    @Published var products: [Product] = []
    
    //IDs for the products that have been marked as favorite.
    @Published var favoriteIDs: Set<Int> = []
    
    // Loads any previously saved favorites when the ViewModel is created, so favorites persist between app launches.
    init() {
        let savedIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        favoriteIDs = Set(savedIDs)
    }
    
    // The key used to save/load favorite IDs in UserDefaults.
    private let favoritesKey = "favoriteIDs"

    
    // Gets products from Tradera´s API and saves them in "products".
    func fetchProducts() async {
        guard let url = URL(string: "https://static.tradera.net/external/recruitment/ProductFeedResult.json") else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let feed = try JSONDecoder().decode(ProductFeed.self, from: data)
            products = feed.products

        } catch {
            print("Kunde inte hämta produkter: \(error)")
        }

    }
    
    // Toggles a product's favorite status and saves the updated list to UserDefaults.
    func toggleFavorite(for product: Product) {
        if favoriteIDs.contains(product.id) {
            favoriteIDs.remove(product.id)
        } else {
            favoriteIDs.insert(product.id)
        }
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey)

    }
    
    // A function that keeps track of whether or not an object has already been added to the favorites list.
    func isFavorite(_ product: Product) -> Bool {
        favoriteIDs.contains(product.id)
    }
    
    // Automatically computes a list of just the favorited products, based on "products" and "favoriteIDs".
    var favoriteProducts: [Product] {
        products.filter { favoriteIDs.contains($0.id) }
    }

    
    


    




}
