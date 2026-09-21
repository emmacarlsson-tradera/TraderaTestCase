import Foundation
import Combine

// ViewModel that fetches products from Tradera and keeps track of whether or not they have been marked as favorite.
@MainActor
class ProductsViewModel: ObservableObject {
    
    // Listan med alla produkter, hämtad från API:et.
    //A list of all the products, fetched from the API.
    @Published var products: [Product] = []
    
    //IDs for the products that have been marked as favorite.
    @Published var favouriteIDs: Set<Int> = []
    
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
    
    // A function that handles the favourites list by adding or removing objects from it.
    func toggleFavourite(for product: Product) {
        if favouriteIDs.contains(product.id) {
            favouriteIDs.remove(product.id)
        } else {
            favouriteIDs.insert(product.id)
        }
    }
    
    // A function that keeps track of whether or not an object has already been added to the favourites list.
    func isFavourite(_ product: Product) -> Bool {
        favouriteIDs.contains(product.id)
    }
    
    // Automatically computes a list of just the favorited products, based on "products" and "favouriteIDs".
    var favouriteProducts: [Product] {
        products.filter { favouriteIDs.contains($0.id) }
    }

    
    


    




}
