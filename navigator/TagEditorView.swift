import SwiftUI
import SwiftData

struct TagEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var tags: [Tag]
    @State private var newTag: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TagListView(tags: tags)
            HStack {
                TextField("New tag", text: $newTag)
                Button("Add") {
                    let name = newTag.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !name.isEmpty else { return }
                    let tag = Tag(name: name)
                    modelContext.insert(tag)
                    tags.append(tag)
                    newTag = ""
                }
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var tags: [Tag] = []
        var body: some View {
            TagEditorView(tags: $tags)
        }
    }
    return PreviewWrapper()
        .modelContainer(for: Item.self, Tag.self, inMemory: true)
}
