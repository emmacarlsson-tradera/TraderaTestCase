import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 200, height: 200)

            Text(product.title)
                .font(.title2)
                .bold()

            Text("\(product.price) \(product.currency)")
                .font(.title3)

            Button(action: {}) {
                Text("Buy now")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            .accessibilityLabel("Close")
            .padding(8)
            .offset(y: -10)
        }
        .presentationDragIndicator(.hidden)


    }
}
