# Navigator

A macOS SwiftUI app for organizing and displaying metadata. This repo also contains `stash-src` (Go) as a reference-only project to mirror concepts and structure in Swift.

## Getting Started
- Xcode (recommended): open `navigator.xcodeproj` with Xcode 15+ and run the “navigator” scheme on macOS 13+ (prefer 14+ for SwiftData).
- SwiftPM (CLI): `swift build` and `swift run navigator`.

## Reference Project (Do Not Build Here)
The `stash-src/` directory is included as an architectural reference only. It is not used at runtime in this repo. For how the Swift app maps its ideas (modular boundaries, background work, tagging flows) into Swift, see DESIGN.md.

## Documentation
- Design overview: see `DESIGN.md`.
- Contributor guide: see `AGENTS.md`.
- Warp usage notes: see `WARP.md`.

