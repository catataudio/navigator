//
//  Tag.swift
//  navigator
//
//  Created by Frederick Arciniegas on 8/26/25.
//

import Foundation
import SwiftData

@Model
final class Tag {
    var name: String

    init(name: String) {
        self.name = name
    }
}
