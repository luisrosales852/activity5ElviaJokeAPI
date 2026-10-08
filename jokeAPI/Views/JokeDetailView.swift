import SwiftUI

struct JokeDetailView: View {
    let joke: Joke
    @State private var isPunchlineVisible = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CategoryIconView(joke: joke, size: 96)

                Text(joke.headline)
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)

                if let punchline = joke.punchline {
                    PunchlineView(punchline: punchline, isVisible: $isPunchlineVisible)
                }

                VStack(spacing: 12) {
                    InfoRow(title: "Category", value: joke.category)
                    InfoRow(title: "Type", value: joke.type == .single ? "One-liner" : "Two-part")
                    InfoRow(title: "Language", value: joke.lang.uppercased())
                    InfoRow(title: "Safe", value: joke.safe ? "Yes" : "No")
                    InfoRow(title: "Joke ID", value: "#\(joke.id)")
                }
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .navigationTitle(joke.category)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct PunchlineView: View {
    let punchline: String
    @Binding var isVisible: Bool

    var body: some View {
        if isVisible {
            Text(punchline)
                .font(.title3)
                .italic()
                .multilineTextAlignment(.center)
                .transition(.opacity)
        } else {
            Button("Reveal punchline") {
                withAnimation { isVisible = true }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

private struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .accessibilityElement(children: .combine)
    }
}
