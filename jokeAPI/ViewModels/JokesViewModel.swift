import SwiftUI

@MainActor
@Observable
final class JokesViewModel {
    enum State {
        case loading
        case loaded([Joke])
        case failed(String)
    }

    private(set) var state: State = .loading

    private let endpoint = URL(string: "https://v2.jokeapi.dev/joke/Any?safe-mode&amount=10")!

    func loadJokes() async {
        state = .loading
        do {
            let (data, response) = try await URLSession.shared.data(from: endpoint)

            if let http = response as? HTTPURLResponse, http.statusCode != 200 {
                state = .failed(serverMessage(from: data, statusCode: http.statusCode))
                return
            }

            let jokes = try JSONDecoder().decode(JokeResponse.self, from: data).jokes
            state = .loaded(jokes)
        } catch {
            state = .failed(message(for: error))
        }
    }

    private func serverMessage(from data: Data, statusCode: Int) -> String {
        if let apiError = try? JSONDecoder().decode(JokeAPIErrorResponse.self, from: data) {
            return "Server error (code \(apiError.code)): \(apiError.message)."
        }
        return "Server error (code \(statusCode)). Please try again later."
    }

    private func message(for error: Error) -> String {
        switch error {
        case let urlError as URLError
            where urlError.code == .notConnectedToInternet || urlError.code == .networkConnectionLost:
            return "No connection. Please try again."
        case let urlError as URLError where urlError.code == .timedOut:
            return "The server took too long to answer. Please try again."
        case is DecodingError:
            return "We couldn't read the jokes from the server."
        default:
            return "Something went wrong. Please try again."
        }
    }
}
