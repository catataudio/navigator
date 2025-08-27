import Foundation
import SwiftData

@Model
final class Metadata: Identifiable, Codable {
    @Attribute(.unique) var id: UUID
    var title: String
    var details: String

    init(id: UUID, title: String, details: String) {
        self.id = id
        self.title = title
        self.details = details
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case details
    }
}
