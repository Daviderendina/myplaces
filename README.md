# Architecture

This project follows an **MVVM + Service Layer** pattern, designed for clarity, testability, and
separation of concerns. Each layer has a single, well-defined responsibility and communicates only
with its immediate neighbor.

---

## Stack

| Layer            | Technology                 |
|------------------|----------------------------|
| UI Framework     | Flutter                    |
| State Management | Riverpod (`AsyncNotifier`) |
| Backend / Remote | Supabase Cloud             |

---

## Layered Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                        VIEW                         │
│           Flutter Widgets (UI only, no logic)       │
└─────────────────────┬───────────────────────────────┘
                      │  reads state / triggers events
                      ▼
┌─────────────────────────────────────────────────────┐
│                    CONTROLLER                       │
│        Riverpod AsyncNotifier (view logic only)     │
│   loading states · navigation · form validation     │
└─────────────────────┬───────────────────────────────┘
                      │  calls use-case methods
                      ▼
┌─────────────────────────────────────────────────────┐
│                     SERVICE                         │
│        Business logic & orchestration layer         │
└─────────────────────┬───────────────────────────────┘
                      │  requests / persists data
                      ▼
┌─────────────────────────────────────────────────────┐
│                   REPOSITORY                        │
│   Single point of data access · maps raw data       │
│                  into Models                        │
└─────────────────────┬───────────────────────────────┘
                      │  executes queries / mutations
                      ▼
┌─────────────────────────────────────────────────────┐
│              REMOTE DATA SOURCE                     │
│                 Supabase Cloud                      │
└─────────────────────────────────────────────────────┘
```

**Data flow (unidirectional):**

```
VIEW → CONTROLLER → SERVICE → REPOSITORY → RemoteDataSource
```

---

## Layer Descriptions

### View

- Contains **Flutter widgets exclusively**.
- Holds **zero business or view logic**: no `if`/`else` on raw data, no direct service calls.
- Observes state exposed by the Controller via Riverpod providers and reacts to changes.
- Delegates every user interaction (button tap, form submit, navigation intent) to the Controller.

### Controller

- Implemented as a **Riverpod `AsyncNotifier`**.
- Responsible for **view-scoped logic only**:
    - Managing `loading`, `error`, and `success` states surfaced to the View.
    - Input / form validation before forwarding data downstream.
    - Triggering navigation as a side-effect of state changes.
- **Does not import or depend on any Repository directly.** All data needs are satisfied through the
  Service layer.

### Service

- Contains **business logic and orchestration**.
- Coordinates calls across one or more Repositories when a use case requires it (e.g., creating an
  order and sending a notification).
- Enforces domain rules and invariants that do not belong in either the UI or the data layer.
- Returns domain **Models** (or throws typed exceptions) to the Controller.

### Repository

- Acts as the **single, authoritative point of data access** for each domain aggregate.
- Abstracts the underlying data source completely: the rest of the application is unaware of
  Supabase-specific types, queries, or response shapes.
- **Maps raw remote responses** (JSON / Supabase DTOs) into typed domain `Model` objects before
  returning them.
- Exposes a clean, intention-revealing interface (`getUser()`, `saveOrder()`, etc.).

### Remote Data Source

- Thin wrapper around the **Supabase Flutter SDK**.
- Executes queries, mutations, and real-time subscriptions.
- Returns raw data (maps / lists) with no domain knowledge.
- Easily replaceable or mockable at the Repository boundary.

---

## Architectural Decision Records

### ADR-01 — AsyncNotifier as Controller

**Decision:** Use Riverpod `AsyncNotifier` instead of plain `StateNotifier` or `ChangeNotifier`.  
**Rationale:** `AsyncNotifier` provides first-class support for async state (`AsyncValue<T>`), which
eliminates boilerplate loading/error handling and maps naturally onto network-driven UI states.

### ADR-02 — Controllers must not depend on Repositories

**Decision:** Controllers are forbidden from importing or calling Repositories directly.  
**Rationale:** Enforcing the Controller → Service boundary ensures that business logic is never
scattered across the view layer, keeps Controllers thin and focused on UI concerns, and makes
Services the single testable entry point for domain behavior.

### ADR-03 — Repository as the sole data-mapping boundary

**Decision:** Raw Supabase responses are mapped to domain Models inside the Repository and never
leak upward.  
**Rationale:** Isolating the mapping at a single boundary means that changing the backend schema or
switching the data source only requires updating the Repository and DataSource — all layers above
remain unaffected.

### ADR-04 — Online-only (v1)

**Decision:** No local persistence or offline support is included in v1.  
**Rationale:** Introducing an offline layer (e.g., local database, sync queue) adds significant
complexity. The current architecture is intentionally kept simple; the Repository interface is
designed so that a `LocalDataSource` can be added alongside `RemoteDataSource` in a future version
without breaking upper layers.

---

## Dependency Graph

```
View
 └── depends on → Controller (AsyncNotifier)
                      └── depends on → Service
                                           └── depends on → Repository
                                                               └── depends on → RemoteDataSource (Supabase)
```

> Each layer depends **only on the layer immediately below it**. No layer skips levels or creates
> circular dependencies.