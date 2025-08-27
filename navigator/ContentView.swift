//
//  ContentView.swift
//  navigator
//
//  Created by Frederick Arciniegas on 8/26/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.title) private var items: [Item]
    @State private var searchText = ""
    @State private var showingNewItem = false
    @State private var selectedItem: Item?

    private var filteredItems: [Item] {
        if searchText.isEmpty { return items }
        return items.filter { item in
            item.title.localizedCaseInsensitiveContains(searchText) ||
            item.tags.contains(where: { $0.name.localizedCaseInsensitiveContains(searchText) })
        }
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedItem) {
                ForEach(filteredItems) { item in
                    ItemRowView(item: item)
                        .tag(item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Items")
            .toolbar {
                Button(action: { showingNewItem = true }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .searchable(text: $searchText)
        } detail: {
            if let selectedItem {
                ItemDetailView(item: selectedItem)
            } else {
                Text("Select an item")
                    .foregroundStyle(.secondary)
            }
        }
        .sheet(isPresented: $showingNewItem) {
            ItemEditView()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let toDelete = offsets.map { filteredItems[$0] }
            for item in toDelete {
                modelContext.delete(item)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, Tag.self, inMemory: true)
}
