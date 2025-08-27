import Foundation
import SwiftData

@Model
final class Scene {
    var title: String
    var details: String?
    var date: Date?
    var urls: [String]
    var performers: [Performer]
    var files: [FileReference]

    init(title: String,
         details: String? = nil,
         date: Date? = nil,
         urls: [String] = [],
         performers: [Performer] = [],
         files: [FileReference] = []) {
        self.title = title
        self.details = details
        self.date = date
        self.urls = urls
        self.performers = performers
        self.files = files
    }
}
