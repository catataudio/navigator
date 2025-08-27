import SwiftUI

struct TagListView: View {
    var tags: [Tag]

    var body: some View {
        HStack(spacing: 4) {
            ForEach(tags) { tag in
                Text(tag.name)
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule().fill(Color.secondary.opacity(0.2))
                    )
            }
        }
    }
}

#Preview {
    TagListView(tags: [Tag(name: "one"), Tag(name: "two")])
        .modelContainer(for: Item.self, Tag.self, inMemory: true)
}
