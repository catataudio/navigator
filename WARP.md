# WARP.md

Guidance for Warp when working with this repository.

## Overview

This repo centers on a macOS SwiftUI app (`navigator`). The `stash-src` project (Go) is included as a reference only to help mirror structure, naming, and data flow in Swift. Do not build or run `stash-src` here.

---

## navigator (SwiftUI/macOS app)

### Build, Run & Develop
- Xcode 15+: `open navigator.xcodeproj` and use the “navigator” scheme.
- SwiftPM: `swift build` (macOS 13+, prefer 14+). Optional: `swift run navigator`.

### Architecture Hints
- Models: `Item`, `Tag`, `Metadata`.
- Services: `MetadataService` orchestrates fetch and storage; consider `Sources/NavigatorAPI` for API contracts.
- App entry: `navigatorApp.swift`; main UI in `ContentView.swift` and related views.

---

## Reference Project (Do Not Build Here)

### stash-src (Go, media manager webapp)
- Mirror its modular boundaries (UI vs. core/services), background jobs, and tagging flows in Swift.
- Map its `cmd/internal/pkg` split to Swift modules (UI vs. Core).

---

## Usage Advice
- Prefer Xcode for build/run/test. Keep Swift code self‑contained.
- When borrowing patterns from Go code, translate them into Swift idioms (Codable models, async/await services, SwiftData or Core Data persistence).

