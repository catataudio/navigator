import SwiftUI

struct ItemRowView: View {
    var item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
                .font(.headline)
            if !item.detail.isEmpty {
                Text(item.detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            if !item.tags.isEmpty {
                TagListView(tags: item.tags)
            }
        }
    }
}

#Preview {
    ItemRowView(item: Item(title: "Sample", detail: "Demo", tags: [Tag(name: "tag")] ))
        .modelContainer(for: [Item.self, Tag.self], inMemory: true)
}
