# Design Overview

This document explains how the Swift app mirrors key ideas from the `stash-src` reference project while remaining fully native to Swift and Xcode.

## Goals
- Keep the SwiftUI app self‑contained and buildable in Xcode.
- Borrow architecture, naming, and data‑flow patterns from the reference without introducing its tooling/runtime.

## Architecture
- UI Layer (SwiftUI): Screens in `navigator/` (e.g., `ContentView`, `Item*View`, `Tag*View`). Small, composable views with state driven by models/services.
- Domain Models: `Item`, `Tag`, `Metadata` as value types; persist via SwiftData (or Core Data) where needed.
- Service Layer: `MetadataService` encapsulates networking, caching, and persistence. Add protocols to enable test doubles.
- API Boundary (optional): `Sources/NavigatorAPI/` for request/response types, endpoint definitions, and adapters.

## Mapping From Reference (`stash-src`)
- Module split (`cmd/internal/pkg`) → Swift separation between UI and Core (models/services).
- Background tasks (scan/index) → async tasks in Swift with cancellation and progress reporting.
- Validation and tagging flows → mirror as Swift domain logic and view models.

## Data Flow
1. View triggers an intent (e.g., fetch metadata).
2. ViewModel/Service composes requests and calls network/storage.
3. Responses are decoded to models (`Codable`) and persisted when appropriate.
4. UI updates from observed state; errors surface via user‑friendly messages.

## Testing
- Unit tests with `XCTest` under `Tests/navigatorTests/`.
- Mock `MetadataService` via a protocol to test views and view models.
- Optional integration tests behind an env flag if a live endpoint is used.

## Future Work
- Add GraphQL codegen (Apollo) using schemas under `GraphQL/` and an Xcode Run Script.
- Factor shared types into `NavigatorCore`/`NavigatorAPI` if the app grows.
- Introduce lightweight caching/persistence strategies for offline use.

