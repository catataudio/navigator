import Foundation
import SwiftData

@Model
final class Performer {
    var name: String
    var disambiguation: String?
    var aliases: [String]
    var gender: String?
    var imagePath: String?

    init(name: String,
         disambiguation: String? = nil,
         aliases: [String] = [],
         gender: String? = nil,
         imagePath: String? = nil) {
        self.name = name
        self.disambiguation = disambiguation
        self.aliases = aliases
        self.gender = gender
        self.imagePath = imagePath
    }
}
