# Joke App

A small SwiftUI app that lists jokes from JokeAPI. Tap a joke to open its details and reveal the punchline.

## What the app does

- **List screen:** shows 10 jokes with a category icon, the joke (or its setup) and its category.
- **Detail screen:** shows the full joke, a **Reveal punchline** button for two-part jokes, and info about the category, type, language, safety and ID.
- **Loading state:** shows a spinner while the jokes are loading.
- **Errors:** if you're offline or the API fails, a friendly message and a **Try Again** button appear. API errors show JokeAPI's own code and message. Pull down on the list to load new jokes.

## API

[JokeAPI](https://jokeapi.dev/)

Endpoint used (GET): **https://v2.jokeapi.dev/joke/Any?safe-mode&amount=10**

## Architecture (MVVM)

| Layer | File | Responsibility |
|---|---|---|
| Model | `Models/Joke.swift`, `Models/JokeResponse.swift` | Decodable structs that match the JSON (success and error bodies) |
| ViewModel | `ViewModels/JokesViewModel.swift` | Makes the GET request, handles errors, exposes `state` (`loading` / `loaded` / `failed`) |
| View | `Views/ContentView.swift` | List + `NavigationStack`, switches on `state` |
| View | `Views/JokeRowView.swift` | One row in the list |
| View | `Views/JokeDetailView.swift` | Detail screen with the punchline and info card |
| View | `Views/CategoryIconView.swift` | Category icon shared by the row and detail screen |
| View | `Views/ErrorView.swift` | Error message + retry button |

## How to run

1. Requirements: **Xcode 27** or newer, **iOS 27** deployment target.
2. Clone the repo and open `jokeAPI.xcodeproj`.
3. Select an iPhone simulator and press **Run** (⌘R).
4. To test the error handling, turn off your Mac's Wi-Fi and press **Try Again**.
