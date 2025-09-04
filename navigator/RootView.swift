//
//  RootView.swift
//  navigator
//
//  Hosts the Items and Library tabs
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Items", systemImage: "list.bullet")
                }

            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "photo.on.rectangle")
                }
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: [Item.self, Tag.self], inMemory: true)
}
