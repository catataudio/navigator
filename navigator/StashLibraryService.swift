//
//  StashLibraryService.swift
//  navigator
//
//  Scans ~/.stash for media assets and publishes results
//

import Foundation

final class StashLibraryService: ObservableObject {
    @Published private(set) var assets: [StashAsset] = []
    @Published private(set) var lastScanError: Error?

    static var defaultRoot: URL {
        FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".stash", isDirectory: true)
    }

    private let imageExtensions: Set<String> = ["jpg", "jpeg", "png", "gif", "heic", "tiff", "bmp", "webp"]
    private let videoExtensions: Set<String> = ["mp4", "mov", "m4v", "avi", "mkv", "webm"]

    func scan(root overrideRoot: URL? = nil) {
        let root = overrideRoot ?? Self.defaultRoot
        Task.detached(priority: .background) { [weak self] in
            guard let self else { return }
            do {
                let results = try self.enumerateAssets(root: root)
                await MainActor.run {
                    self.assets = results.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
                    self.lastScanError = nil
                }
            } catch {
                await MainActor.run {
                    self.assets = []
                    self.lastScanError = error
                }
            }
        }
    }

    private func enumerateAssets(root: URL) throws -> [StashAsset] {
        var discovered: [StashAsset] = []
        let fm = FileManager.default

        var isDir: ObjCBool = false
        if !fm.fileExists(atPath: root.path, isDirectory: &isDir) || !isDir.boolValue {
            // No ~/.stash directory yet — return empty list without error
            return []
        }

        let resourceKeys: Set<URLResourceKey> = [.isRegularFileKey, .fileSizeKey, .contentModificationDateKey, .isDirectoryKey]
        let enumerator = fm.enumerator(at: root, includingPropertiesForKeys: Array(resourceKeys), options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
            // Continue enumeration on error
            return true
        })

        while let fileURL = enumerator?.nextObject() as? URL {
            let rv = try fileURL.resourceValues(forKeys: resourceKeys)
            if rv.isDirectory == true { continue }
            guard rv.isRegularFile == true else { continue }

            let ext = fileURL.pathExtension.lowercased()
            let type: StashAssetType
            if imageExtensions.contains(ext) {
                type = .image
            } else if videoExtensions.contains(ext) {
                type = .video
            } else {
                type = .other
            }

            let size = UInt64(rv.fileSize ?? 0)
            let modified = rv.contentModificationDate ?? Date.distantPast
            discovered.append(StashAsset(url: fileURL, name: fileURL.lastPathComponent, type: type, size: size, modifiedAt: modified))
        }

        return discovered
    }
}

