//
//  StashAsset.swift
//  navigator
//
//  Represents a media asset discovered under ~/.stash
//

import Foundation

enum StashAssetType: String, Codable, CaseIterable {
    case image
    case video
    case other
}

struct StashAsset: Identifiable, Hashable, Codable {
    var id: String { url.path }
    let url: URL
    let name: String
    let type: StashAssetType
    let size: UInt64
    let modifiedAt: Date
}

