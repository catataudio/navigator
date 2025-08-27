import Foundation
import SwiftData

@Model
final class FileReference {
    var path: String
    var size: Int
    var checksum: String?
    var modified: Date?

    init(path: String, size: Int, checksum: String? = nil, modified: Date? = nil) {
        self.path = path
        self.size = size
        self.checksum = checksum
        self.modified = modified
    }
}
