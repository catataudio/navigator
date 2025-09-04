//
//  LibraryView.swift
//  navigator
//
//  Displays media assets found under ~/.stash
//

import SwiftUI
import AppKit

private enum LibraryFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case images = "Images"
    case videos = "Videos"
    case other = "Other"
    var id: String { rawValue }
}

struct LibraryView: View {
    @StateObject private var service = StashLibraryService()
    @State private var searchText: String = ""
    @State private var filter: LibraryFilter = .all

    private var filteredAssets: [StashAsset] {
        service.assets.filter { asset in
            // Filter by type
            switch filter {
            case .all: true
            case .images: asset.type == .image
            case .videos: asset.type == .video
            case .other: asset.type == .other
            }
        }.filter { asset in
            // Filter by name
            guard !searchText.isEmpty else { return true }
            return asset.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var gridLayout: [GridItem] {
        [GridItem(.adaptive(minimum: 140), spacing: 12)]
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            content
        }
        .onAppear { service.scan() }
    }

    private var header: some View {
        HStack(spacing: 12) {
            Picker("Filter", selection: $filter) {
                ForEach(LibraryFilter.allCases) { f in
                    Text(f.rawValue).tag(f)
                }
            }
            .pickerStyle(.segmented)

            Spacer()

            TextField("Search", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 300)
        }
        .padding(12)
    }

    private var content: some View {
        Group {
            if let error = service.lastScanError {
                VStack(spacing: 8) {
                    Text("Failed to scan ~/.stash")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if service.assets.isEmpty {
                VStack(spacing: 8) {
                    Text("No assets found in ~/.stash")
                        .font(.headline)
                    Text("Add images or videos under \"~/.stash\" to populate your library.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: gridLayout, spacing: 12) {
                        ForEach(filteredAssets) { asset in
                            LibraryAssetCell(asset: asset)
                        }
                    }
                    .padding(12)
                }
            }
        }
    }
}

private struct LibraryAssetCell: View {
    let asset: StashAsset

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.secondary.opacity(0.1))
                    .aspectRatio(16/9, contentMode: .fit)

                thumbnail
                    .clipped()
                    .cornerRadius(6)
                    .padding(4)
            }

            Text(asset.name)
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.middle)
                .help(asset.url.path)
        }
        .contextMenu {
            Button("Reveal in Finder") {
                NSWorkspace.shared.activateFileViewerSelecting([asset.url])
            }
        }
    }

    @ViewBuilder
    private var thumbnail: some View {
        switch asset.type {
        case .image:
            if let img = NSImage(contentsOf: asset.url) {
                Image(nsImage: img)
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder(symbol: "photo")
            }
        case .video:
            placeholder(symbol: "video")
        case .other:
            placeholder(symbol: "doc")
        }
    }

    private func placeholder(symbol: String) -> some View {
        Image(systemName: symbol)
            .font(.system(size: 36, weight: .regular))
            .foregroundStyle(.secondary)
    }
}

#Preview {
    LibraryView()
}

