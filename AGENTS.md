# Repository Guidelines

## Project Structure & Module Organization
- `navigator/`: macOS SwiftUI app (entry: `navigatorApp.swift`, views like `ContentView.swift`, assets in `Assets.xcassets`).
- `Sources/NavigatorAPI/`: Reserved for Swift API/contracts if you split UI and services.
- `GraphQL/`: Schemas/operations for potential Swift codegen (optional).
- `stash-src/`: Reference only. Do not build/run here; use it to mirror structure, naming, and data flow in Swift.
- Xcode project: `navigator.xcodeproj`.

## Build, Test, and Development Commands
- Xcode (recommended): `open navigator.xcodeproj` and use the “navigator” scheme.
- SwiftPM (CLI): `swift build` and `swift run navigator` (macOS 13+, prefer 14+).

## Coding Style & Naming Conventions
- Swift 5.9: Types `UpperCamelCase`; methods/vars `lowerCamelCase`; 4‑space indent.
- File naming: One primary type per file (e.g., `TagEditorView.swift`). Prefer small SwiftUI views and pure value types.

## Testing Guidelines
- Add `XCTest` under `Tests/navigatorTests/` with `test...` methods; run via Xcode or `swift test`.
- Integration tests are optional; gate behind env flags if they depend on network.

## Commit & Pull Request Guidelines
- Commits: Imperative, concise subject, optional scope. Example: `navigator: add TagEditorView validation`.
- PRs: Include description, linked issues, screenshots for UI, and steps to verify in Xcode. Ensure `swift build` passes.

## Security & Configuration Tips
- Do not commit secrets or `.env` files. If adding GraphQL, check in schemas but generate Swift types during build (e.g., Apollo run script).

## Agent Notes
- Treat `stash-src` as architectural reference only. Keep Swift code self‑contained, and update Xcode settings if you reorganize modules.

