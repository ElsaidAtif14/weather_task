# 🌤️ Weather App - Clean Architecture & BLoC

A modern Flutter weather application built with Clean Architecture and `flutter_bloc` state management.

---

## ✨ Features

- 📍 Real-time weather data by location or city search
- 🎨 Clean, modular UI components
- 🔄 BLoC/Cubit state management
- 📡 API integration using `dio`
- 💾 Local caching support
- 🌐 Network connectivity monitoring
- 💉 Dependency injection with `get_it`

---

## 🏗️ Project Architecture

This app follows Clean Architecture principles with separated layers:

```text
lib/
├── core/
│   ├── connection/            # Network info & connection status
│   ├── databases/
│   │   ├── api/               # API consumer, endpoints
│   │   └── cache/             # Cache helper
│   ├── errors/                # Failures, exceptions, error models
│   ├── helper/                # UI helpers and utilities
│   └── services/              # Location and other services
├── data/
│   ├── datasources/           # Remote and local data sources
│   ├── models/                # Data models
│   └── repositories/          # Repository implementations
├── domain/
│   ├── entities/              # Domain entities
│   ├── repositories/          # Abstract repository contracts
│   └── usecases/              # Business logic use cases
└── presentation/
    └── home/
        ├── cubit/             # Weather cubit and states
        └── views/             # UI screens and widgets
```

---

## 🛠️ Tech Stack

- Language: Dart
- Framework: Flutter
- State management: `flutter_bloc`
- Dependency injection: `get_it`
- Networking: `dio`
- Animations: `lottie`
- Local storage: `shared_preferences`

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- IDE: VS Code or Android Studio

### Install

```bash
git clone https://github.com/ElsaidAtif14/weather_task.git
cd weather_task
flutter pub get
```

### Configure API Key

Update `lib/core/databases/api/end_points.dart` with your weather API key.

### Run the app

```bash
flutter run
```

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome.

---

## 📝 License

This project is distributed under the MIT License. See `LICENSE` for details.
