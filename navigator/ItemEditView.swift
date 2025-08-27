//
//  ItemEditView.swift
//  navigator
//
//  Created by Frederick Arciniegas on 8/26/25.
//

import SwiftUI
import SwiftData

struct ItemEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State var item: Item?
    @State private var title: String
    @State private var detail: String
    @State private var tags: [Tag]

    init(item: Item? = nil) {
        _item = State(initialValue: item)
        _title = State(initialValue: item?.title ?? "")
        _detail = State(initialValue: item?.detail ?? "")
        _tags = State(initialValue: item?.tags ?? [])
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Detail", text: $detail)
                Section("Tags") {
                    TagEditorView(tags: $tags)
                }
            }
            .navigationTitle(item == nil ? "New Item" : "Edit Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                }
            }
        }
    }

    private func save() {
        if let item {
            item.title = title
            item.detail = detail
            item.tags = tags
        } else {
            let newItem = Item(title: title, detail: detail, tags: tags)
            modelContext.insert(newItem)
        }
        dismiss()
    }
}

#Preview {
    ItemEditView()
        .modelContainer(for: Item.self, Tag.self, inMemory: true)
}
