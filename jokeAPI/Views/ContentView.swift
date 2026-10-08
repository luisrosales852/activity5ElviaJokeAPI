import SwiftUI

struct ContentView: View {
    @State private var viewModel = JokesViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Jokes")
                .navigationDestination(for: Joke.self) { joke in
                    JokeDetailView(joke: joke)
                }
        }
        .task { await viewModel.loadJokes() }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading jokes…")
        case .failed(let message):
            ErrorView(message: message) {
                Task { await viewModel.loadJokes() }
            }
        case .loaded(let jokes):
            List(jokes) { joke in
                NavigationLink(value: joke) {
                    JokeRowView(joke: joke)
                }
            }
            .refreshable { await viewModel.loadJokes() }
        }
    }
}

#Preview {
    ContentView()
}
