import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var metadataItems: [Metadata]
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationSplitView {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    List(metadataItems) { item in
                        VStack(alignment: .leading) {
                            Text(item.title).font(.headline)
                            Text(item.details).font(.subheadline)
                        }
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button("Reload") {
                        Task { await loadMetadata() }
                    }
                }
            }
            .task {
                await loadMetadata()
            }
            .alert("Error", isPresented: .constant(errorMessage != nil), actions: {
                Button("OK", role: .cancel) { errorMessage = nil }
            }, message: {
                if let errorMessage { Text(errorMessage) }
            })
        } detail: {
            Text("Select a metadata item")
        }
    }

    private func loadMetadata() async {
        isLoading = true
        defer { isLoading = false }
        let service = MetadataService()
        do {
            let items = try await service.fetchMetadata()
            for item in items {
                modelContext.insert(item)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Metadata.self, inMemory: true)
}
