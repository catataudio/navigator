import Foundation

struct MetadataService {
    enum ServiceError: Error {
        case invalidResponse
    }

    func fetchMetadata() async throws -> [Metadata] {
        guard let url = URL(string: "https://example.com/metadata") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw ServiceError.invalidResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Metadata].self, from: data)
    }
}
