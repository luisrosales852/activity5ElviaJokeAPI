import SwiftUI

struct JokeRowView: View {
    let joke: Joke

    var body: some View {
        HStack(spacing: 16) {
            CategoryIconView(joke: joke, size: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(joke.headline)
                    .font(.headline)
                    .lineLimit(2)
                Text(joke.category)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}
