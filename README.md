# Countries App 🌍

A premium, high-performance Flutter application for exploring world countries, built with Clean Architecture and a professional "Beefian" aesthetic.

## Features

- **Explore Countries**: Browse a comprehensive list of world countries with real-time search.
- **Detailed Insights**: View in-depth statistics including population, area, timezones, and regional data.
- **Figma-Aligned UI**: Premium, state-of-the-art design following modern UX standards.
- **Persistent Favorites**: Save your favorite countries for quick access, powered by Hive local storage.
- **High-Performance Navigation**: Smooth transitions and Hero animations for a seamless experience.

## Technical Stack

- **Core**: Flutter & Dart
- **Architecture**: Flutter Clean Architecture (Domain, Data, Presentation)
- **State Management**: BLoC / Cubit
- **Local Storage**: Hive (for favorites)
- **UI Components**: CachedNetworkImage, Google Fonts (JetBrains Mono)

## Architecture & Technology Choices

- **State Management (BLoC/Cubit)**: Chosen for its predictable, event-driven state transitions which are highly scalable and map perfectly to Clean Architecture patterns. Unidirectional data flow makes debugging UI states simple.
- **Dependency Injection (get_it)**: Used as a service locator to decouple feature layers, making classes easily testable by injecting mock dependencies without Flutter context overhead.
- **Local Storage (Hive)**: A lightweight and extremely fast NOSQL key-value database written in pure Dart, chosen over SharedPreferences for its superior read/write speeds when persisting favorite countries.
- **Data Models (Freezed & JSON Serializable)**: Utilized to enforce immutability and handle tedious boilerplate when parsing the Rest Countries API JSON data.

## Getting Started 

1.  **Clone the repo**:
    ```bash
    git clone https://github.com/ibxbit/countries_app.git
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the app**:
    ```bash
    flutter run
    ```
