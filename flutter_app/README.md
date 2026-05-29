# TuneFlow Music (Flutter App)

This repository contains the Flutter client for TuneFlow Music and a **Serverpod** backend located at:

`flutter_app/backend/backend_server`

## Backend (Serverpod)

To run the backend locally:

1. Start Postgres + Redis using Docker:

```
cd flutter_app/backend/backend_server
docker compose up --build --detach
```

2. Start the Serverpod server:

```
dart bin/main.dart
```

To stop services:

```
docker compose stop
```

## Flutter App

Run the Flutter app as usual (e.g. `flutter run`).

## Where to edit backend code

- Endpoints: `flutter_app/backend/backend_server/lib/src/endpoints/`
- Models: `flutter_app/backend/backend_server/lib/src/models/`
- Config: `flutter_app/backend/backend_server/config/`
- Migrations: `flutter_app/backend/backend_server/migrations/`
