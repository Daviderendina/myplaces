# 1. Contesto del progetto

MyPlaces è una app Flutter per permettere agli utenti di tracciare i propri viaggi e punti di
interesse (POI — Points of
Interest). Le sue funzionalità principali sono

- Autenticazione utente (email/password e Google OAuth)
- Visualizzazione di una mappa interattiva con i propri POI
- Gestione CRUD completa dei viaggi
- Gestione CRUD completa delle collezioni di POI
- Profilo utente con statistiche aggregate

#### 1.1 Tech Stack

| Categoria        | Package                               |
|------------------|---------------------------------------|
| State management | `riverpod` / `flutter_riverpod`       |
| Navigation       | `go_router`                           |
| Backend          | (per ora mocked)                      |
| Maps             | `flutter_map` / `google_maps_flutter` |
| Auth             | (per ora mocked)                      |
| Testing          | `flutter_test`, `mocktail`            |

Usa sempre le versioni stabili più recenti compatibili tra loro. Risolvi eventuali conflitti di
versione prima di procedere.

# 2. Architettura software

Il progetto segue il pattern **MVVM + Service Layer**. Ogni layer ha una responsabilità singola e
comunica solo con il layer immediatamente adiacente. Il flusso della chiamata va dall'alto al basso.

- **Screen** (VIEW) è la parte UI.
    - Contiene esclusivamente widget Flutter.
    - No logica sui dati: nessun `if/else` su dati raw, nessuna chiamata diretta a service o
      repository.
    - Solo logica solo relativa alla UI (es. if per far vedere un elemento della UI)
    - Osserva lo stato esposto dal Controller tramite provider Riverpod e reagisce ai cambiamenti.
    - Delega ogni interazione utente (tap, submit, navigazione) al Controller.
- **Controller**
    - Implementato come **Riverpod `AsyncNotifier`** o `Notifier` per stati sincroni.
    - Responsabile esclusivamente di **logica view-scoped**:
    - Validazione input / form prima di propagare downstream.
    - Gestione della navigazione tra le pagine tramite go_router
    - Tutte le esigenze dati passano dal Service.
    - Un Controller per schermata (o per sotto-componente complesso).
- **Service**
    - Contiene **business logic e orchestrazione**.
    - Coordina chiamate a uno o più Repository quando un use case lo richiede.
    - Fa rispettare regole di dominio e invarianti (es. un viaggio non può avere `end_date` <
      `start_date`).
    - Restituisce **Model** tipizzati (o lancia eccezioni tipizzate) al Controller.
    - **Dipendenze piatte**: nessun Service chiama un altro Service. Se la logica è condivisa,
      estrarla
      in una funzione/utility.
      -**Repository**
    - **Unico punto di accesso** per ogni aggregato di dominio.
    - **Mappa le risposte raw** (JSON / Supabase DTOs) in oggetti `Model` tipizzati prima di
      restituirli.
    - **Non contiene business logic**: solo lettura/scrittura dati.
- **Data source**
    - Esegue query, mutation e (opzionalmente) subscription realtime.
    - Restituisce dati raw (`Map<String, dynamic>` / `List<Map<String, dynamic>>`).
    - Nessuna conoscenza di dominio.
    - Facilmente sostituibile o mockabile al confine del Repository.

Per ora considera:

- Il data source deve essere mocked.
- La gestione della parte network deve essere tutta asincrona
- Solo online (nessun supporto offline)
- Un solo utente per account (no collaborazione)
- Dati privati per utente per sviluppi futuri - dipende dal cloud

#### 2.1 Gestione errori

- Il `RemoteDataSource` rilancia le eccezioni Supabase senza modificarle.
- Il `Repository` cattura le eccezioni Supabase e le converte in eccezioni di dominio tipizzate (es.
  `DataNotFoundException`, `NetworkException`).
- Il `Service` può aggiungere contesto o rilanciare.
- Il `Controller` cattura le eccezioni e le espone come `AsyncValue.error(...)` alla View.
- La View mostra messaggi di errore user-friendly senza esporre dettagli tecnici.

## 3. Struttura cartelle

```
lib/
├── main.dart # Entry point, init Supabase, init Riverpod
├── app.dart # MaterialApp.router con go_router
│
├── core/
│ ├── constants/ ..     # temi, colori, layout, etc.
│ ├── model/ ..         # classi di dominio cross
│ ├── errors/
│ │ └── app_exceptions.dart     # eccezioni di dominio tipizzate
│ └── utils/ ..
│
├── shared/     # Elementi condivisi dalle varie features
│ ├── widgets/ ...
│
└── features/
├── <FEATURE_NAME>>/
│ ├── providers.dart -> contiene la definizione dei provider specifici per quella feature
│ ├── datasources/ ...
│ ├── repositories/ ...
│ ├── models/ ...
│ ├── services/ ...
│ ├── controllers/ ...
│ ├── screens/
│ │ └── widgets/ ...
```

## 4. Istruzioni per lo sviluppo

- NON aggiungere margini e padding di tua iniziativa
- NON scommentare mai righe commentate
- Limitati a fare esattamente quanto ti chiedo
- *NON* usare freezed o altro, voglio riverpod puro con AsyncNotifier e state.
- **Genera sempre i test** contestualmente all'implementazione, non alla fine.
- **Non usare `setState`** al di fuori di widget leaf puramente locali (es. toggle visibilità
  password).
- **Nessun `print()`** nel codice di produzione. Usa un logger o le eccezioni tipizzate.
- **Commenta solo il perché**, non il cosa. Il codice deve essere auto-esplicativo.
- *NON* commentare il codice
- **Se una istruzione in questo documento è ambigua**, scegli l'interpretazione più conservativa (
  meno codice, più semplice) e documenta la scelta come commento inline.
