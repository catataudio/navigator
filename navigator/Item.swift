//
//  Item.swift
//  navigator
//
//  Created by Frederick Arciniegas on 8/26/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var id: UUID
    var title: String
    var detail: String
    var tags: [Tag]
    var timestamp: Date

    init(title: String, detail: String = "", tags: [Tag] = [], timestamp: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.detail = detail
        self.tags = tags
        self.timestamp = timestamp
    }
}

extension Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
