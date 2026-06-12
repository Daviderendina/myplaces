# Flutter Travel Tracker App — Development Spec

> **Questo documento è la specifica completa dell'app. Contiene tutto il contesto necessario per
sviluppare l'applicazione senza ulteriori spiegazioni esterne. Seguilo come fonte di verità unica.**

---

## Indice

1. [Contesto del progetto](#1-contesto-del-progetto)
2. [Stack tecnologico](#2-stack-tecnologico)
3. [Architettura](#3-architettura)
4. [Struttura cartelle](#4-struttura-cartelle)
5. [Schermate](#5-schermate)
6. [Modelli dati principali](#6-modelli-dati-principali)
7. [Schema database Supabase](#7-schema-database-supabase)
8. [Navigazione](#8-navigazione)
9. [Gestione dello stato](#9-gestione-dello-stato)
10. [Decisioni architetturali (ADR)](#10-decisioni-architetturali-adr)
11. [Istruzioni per lo sviluppo](#11-istruzioni-per-lo-sviluppo)

---

## 1. Contesto del progetto

**Nome app:** TravelTracker  
**Piattaforma:** Flutter (iOS + Android)  
**Scopo:** Permettere agli utenti di tracciare i propri viaggi e punti di interesse (POI — Points of
Interest). Il focus principale è la gestione dei viaggi: creazione, aggiornamento, associazione di
POI a viaggi e raccolta di POI in collezioni tematiche.

**Funzionalità principali:**

- Autenticazione utente (email/password e Google OAuth)
- Visualizzazione di una mappa interattiva con i propri POI
- Gestione CRUD completa dei viaggi
- Gestione CRUD completa delle collezioni di POI
- Profilo utente con statistiche aggregate

**Vincoli v1:**

- Solo online (nessun supporto offline)
- Un solo utente per account (no collaborazione)
- Dati privati per utente (Row Level Security attiva su Supabase)

---

## 2. Stack tecnologico

| Categoria        | Tecnologia                        | Note                                            |
|------------------|-----------------------------------|-------------------------------------------------|
| UI Framework     | Flutter (SDK stabile più recente) | Null safety abilitato                           |
| State Management | Riverpod (`AsyncNotifier`)        | Nessun `setState` fuori dai widget leaf         |
| Modelli          | `freezed` + `json_serializable`   | Immutabilità garantita, `copyWith` generato     |
| Backend / Cloud  | Supabase (piano gratuito, cloud)  | Auth, Database (PostgreSQL), realtime opzionale |
| Mappe            | `flutter_map` + `latlong2`        | Tile provider: OpenStreetMap (gratuito)         |

> Usa sempre le versioni stabili più recenti compatibili tra loro. Risolvi eventuali conflitti di
> versione prima di procedere.

---

## 3. Architettura

Il progetto segue il pattern **MVVM + Service Layer**. Ogni layer ha una responsabilità singola e
comunica solo con il layer immediatamente adiacente.

### 3.1 Stack dei layer

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
                      │  calls service methods
                      ▼
┌─────────────────────────────────────────────────────┐
│                     SERVICE                         │
│     Business logic · orchestration · mapping        │
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

**Flusso dati (unidirezionale):**

```
VIEW → CONTROLLER → SERVICE → REPOSITORY → RemoteDataSource
```

### 3.2 Regole per layer

#### VIEW

- Contiene **esclusivamente widget Flutter**.
- **Zero logica**: nessun `if/else` su dati raw, nessuna chiamata diretta a service o repository.
- Osserva lo stato esposto dal Controller tramite provider Riverpod e reagisce ai cambiamenti.
- Delega ogni interazione utente (tap, submit, navigazione) al Controller.
- Gestisce i permessi runtime (es. `geolocator`) e li segnala al Controller tramite callback.

#### CONTROLLER (`AsyncNotifier`)

- Implementato come **Riverpod `AsyncNotifier`** o `Notifier` per stati sincroni.
- Responsabile esclusivamente di **logica view-scoped**:
    - Gestione stati `loading`, `error`, `success` esposti alla View.
    - Validazione input / form prima di propagare downstream.
    - Triggering navigazione come side-effect di cambiamenti di stato.
- **Non importa mai Repository direttamente.** Tutte le esigenze dati passano dal Service.
- Un Controller per schermata (o per sotto-componente complesso).

#### SERVICE

- Contiene **business logic e orchestrazione**.
- Coordina chiamate a uno o più Repository quando un use case lo richiede.
- Fa rispettare regole di dominio e invarianti (es. un viaggio non può avere `end_date` <
  `start_date`).
- Restituisce **Model** tipizzati (o lancia eccezioni tipizzate) al Controller.
- **Dipendenze piatte**: nessun Service chiama un altro Service. Se la logica è condivisa, estrarla
  in una funzione/utility pura nel layer `core/`.

#### REPOSITORY

- **Unico punto di accesso** per ogni aggregato di dominio.
- Nasconde completamente la sorgente dati: il resto dell'applicazione non conosce tipi Supabase,
  query SQL o shape delle risposte.
- **Mappa le risposte raw** (JSON / Supabase DTOs) in oggetti `Model` tipizzati prima di
  restituirli.
- Espone un'interfaccia chiara e semantica: `getTrip(id)`, `saveTrip(trip)`, `deleteTrip(id)`, ecc.
- **Non contiene business logic**: solo lettura/scrittura dati.

#### REMOTE DATA SOURCE

- Thin wrapper intorno all'**SDK `supabase_flutter`**.
- Esegue query, mutation e (opzionalmente) subscription realtime.
- Restituisce dati raw (`Map<String, dynamic>` / `List<Map<String, dynamic>>`).
- Nessuna conoscenza di dominio.
- Facilmente sostituibile o mockabile al confine del Repository.

### 3.3 Dependency Graph

```
View
 └── depends on → Controller (AsyncNotifier)
                      └── depends on → Service
                                           └── depends on → Repository
                                                               └── depends on → RemoteDataSource (Supabase)
```

> Ogni layer dipende **solo dal layer immediatamente sotto**. Nessun layer salta livelli o crea
> dipendenze circolari.

### 3.4 Gestione errori

- Il `RemoteDataSource` rilancia le eccezioni Supabase senza modificarle.
- Il `Repository` cattura le eccezioni Supabase e le converte in eccezioni di dominio tipizzate (es.
  `DataNotFoundException`, `NetworkException`).
- Il `Service` può aggiungere contesto o rilanciare.
- Il `Controller` cattura le eccezioni e le espone come `AsyncValue.error(...)` alla View.
- La View mostra messaggi di errore user-friendly senza esporre dettagli tecnici.

---

## 4. Struttura cartelle

```
lib/
├── main.dart                          # Entry point, init Supabase, init Riverpod
├── app.dart                           # MaterialApp.router con go_router
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── supabase_constants.dart    # nomi tabelle, colonne
│   ├── errors/
│   │   └── app_exceptions.dart        # eccezioni di dominio tipizzate
│   ├── extensions/
│   │   └── datetime_extensions.dart
│   └── utils/
│       └── validators.dart            # funzioni di validazione pure
│
├── shared/
│   ├── widgets/
│   │   ├── app_button.dart
│   │   ├── app_text_field.dart
│   │   ├── error_widget.dart
│   │   └── loading_overlay.dart
│   └── providers/
│       └── supabase_provider.dart     # provider per SupabaseClient singleton
│
└── features/
    ├── auth/
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── auth_remote_datasource.dart
    │   │   └── repositories/
    │   │       └── auth_repository_impl.dart
    │   ├── domain/
    │   │   ├── models/
    │   │   │   └── app_user.dart          # freezed
    │   │   ├── repositories/
    │   │   │   └── auth_repository.dart   # interfaccia astratta
    │   │   └── services/
    │   │       └── auth_service.dart
    │   └── presentation/
    │       ├── controllers/
    │       │   └── auth_controller.dart
    │       └── screens/
    │           └── login_screen.dart
    │
    ├── trips/
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── trips_remote_datasource.dart
    │   │   └── repositories/
    │   │       └── trips_repository_impl.dart
    │   ├── domain/
    │   │   ├── models/
    │   │   │   └── trip.dart              # freezed
    │   │   ├── repositories/
    │   │   │   └── trips_repository.dart
    │   │   └── services/
    │   │       └── trips_service.dart
    │   └── presentation/
    │       ├── controllers/
    │       │   ├── trips_list_controller.dart
    │       │   └── trip_detail_controller.dart
    │       └── screens/
    │           ├── trips_screen.dart
    │           └── trip_detail_screen.dart
    │
    ├── pois/
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── pois_remote_datasource.dart
    │   │   └── repositories/
    │   │       └── pois_repository_impl.dart
    │   ├── domain/
    │   │   ├── models/
    │   │   │   └── poi.dart               # freezed
    │   │   ├── repositories/
    │   │   │   └── pois_repository.dart
    │   │   └── services/
    │   │       └── pois_service.dart
    │   └── presentation/
    │       ├── controllers/
    │       │   └── pois_controller.dart
    │       └── widgets/
    │           └── poi_marker.dart
    │
    ├── map/
    │   └── presentation/
    │       ├── controllers/
    │       │   └── map_controller.dart
    │       └── screens/
    │           └── map_screen.dart
    │
    ├── collections/
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── collections_remote_datasource.dart
    │   │   └── repositories/
    │   │       └── collections_repository_impl.dart
    │   ├── domain/
    │   │   ├── models/
    │   │   │   └── collection.dart        # freezed
    │   │   ├── repositories/
    │   │   │   └── collections_repository.dart
    │   │   └── services/
    │   │       └── collections_service.dart
    │   └── presentation/
    │       ├── controllers/
    │       │   └── collections_controller.dart
    │       └── screens/
    │           ├── collections_screen.dart
    │           └── collection_detail_screen.dart
    │
    └── profile/
        ├── domain/
        │   └── services/
        │       └── profile_service.dart
        └── presentation/
            ├── controllers/
            │   └── profile_controller.dart
            └── screens/
                └── profile_screen.dart
```

---

## 10. Decisioni architetturali (ADR)

### ADR-01 — `AsyncNotifier` come Controller

**Decisione:** Usare `AsyncNotifier` di Riverpod invece di `StateNotifier` o `ChangeNotifier`.  
**Rationale:** `AsyncNotifier` fornisce supporto nativo per `AsyncValue<T>`, eliminando boilerplate
per stati loading/error e mappandosi naturalmente su UI network-driven.

### ADR-02 — Controller non dipende da Repository

**Decisione:** I Controller non possono importare o chiamare Repository direttamente.  
**Rationale:** Mantenere la boundary Controller → Service assicura che la business logic non sia mai
dispersa nel layer view, mantiene i Controller focalizzati su UI concerns, e rende i Service l'unico
punto di test per il comportamento di dominio.

### ADR-03 — Repository come unico confine di mapping

**Decisione:** Le risposte raw di Supabase vengono mappate in Model nel Repository e non risalgono
mai ai layer superiori.  
**Rationale:** Isolare il mapping in un unico confine significa che cambiare lo schema backend o
sostituire la sorgente dati richiede solo l'aggiornamento di Repository e DataSource — tutti i layer
superiori rimangono invariati.

### ADR-04 — Online-only (v1)

**Decisione:** Nessuna persistenza locale o supporto offline in v1.  
**Rationale:** Un layer offline (es. Isar + sync queue) aggiunge complessità significativa.
L'interfaccia del Repository è progettata in modo che un `LocalDataSource` (Isar) possa essere
affiancato al `RemoteDataSource` in v2 senza toccare i layer superiori.

### ADR-05 — Supabase vs Firebase

**Decisione:** Supabase come backend cloud.  
**Rationale:** Open source, PostgreSQL nativo con RLS granulare, SDK Flutter ufficiale maturo, piano
gratuito generoso. La struttura relazionale si adatta meglio alle relazioni many-to-many (trip_pois,
collection_pois) rispetto a un documento store.

### ADR-06 — Strategia conflitti multi-device: last-write-wins

**Decisione:** Ogni tabella ha un campo `updated_at` aggiornato ad ogni scrittura. In caso di
conflitti multi-device, vince l'ultima scrittura.  
**Rationale:** Semplice da implementare in v1. Adeguato per un'app single-user. In v2 si potrà
introdurre conflict resolution ottimistica se necessario.

### ADR-07 — Dipendenze piatte nei Service

**Decisione:** Nessun Service chiama un altro Service.  
**Rationale:** Evita catene di dipendenza difficili da tracciare e da testare. La logica condivisa
tra Service viene estratta in funzioni pure nel layer `core/utils/`.

### ADR-08 — `flutter_map` con OpenStreetMap

**Decisione:** Usare `flutter_map` con tile provider OpenStreetMap invece di Google Maps.  
**Rationale:** Gratuito, nessuna API key necessaria per sviluppo, open source, sufficientemente
ricco per le feature richieste in v1.

---

## 11. Istruzioni per lo sviluppo

> **Segui queste istruzioni in ordine. Non saltare fasi. Non iniziare una fase successiva se quella
corrente non compila e non passa i test.**

---

### Regole generali per tutto lo sviluppo

- **Rispetta sempre le regole dei layer** (sezione 3.2). Se hai dubbi su dove mettere del codice,
  torna a rileggere quella sezione.
- **Genera sempre i test** contestualmente all'implementazione, non alla fine.
- **Non usare `setState`** al di fuori di widget leaf puramente locali (es. toggle visibilità
  password).
- **Non esporre mai tipi Supabase** (es. `PostgrestList`, `User` di supabase) fuori dal layer
  `data/`. Usa sempre i Model del dominio.
- **Ogni file di Model annotato con `@freezed`** deve essere seguito da
  `flutter pub run build_runner build --delete-conflicting-outputs`.
- **Nessun `print()`** nel codice di produzione. Usa un logger o le eccezioni tipizzate.
- **Commenta solo il perché**, non il cosa. Il codice deve essere auto-esplicativo.
- **Se una istruzione in questo documento è ambigua**, scegli l'interpretazione più conservativa (
  meno codice, più semplice) e documenta la scelta come commento inline.