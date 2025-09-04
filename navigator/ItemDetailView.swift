//
//  ItemDetailView.swift
//  navigator
//
//  Created by Frederick Arciniegas on 8/26/25.
//

import SwiftUI
import SwiftData

struct ItemDetailView: View {
    @Bindable var item: Item
    @State private var showingEdit = false

    var body: some View {
        Form {
            Section("Details") {
                Text(item.detail.isEmpty ? "No details" : item.detail)
            }
            Section("Tags") {
                if item.tags.isEmpty {
                    Text("No tags")
                } else {
                    TagListView(tags: item.tags)
                }
            }
            Section("Created") {
                Text(item.timestamp.formatted(date: .numeric, time: .shortened))
            }
        }
        .navigationTitle(item.title)
        .toolbar {
            Button("Edit") { showingEdit = true }
        }
        .sheet(isPresented: $showingEdit) {
            ItemEditView(item: item)
        }
    }
}

#Preview {
    let item = Item(title: "Sample", detail: "Example item", tags: [Tag(name: "swift")])
    ItemDetailView(item: item)
        .modelContainer(
            for: [Item.self, Tag.self],
            inMemory: true,
            isAutosaveEnabled: true
        )
}
