import SwiftUI

struct CategoryIconView: View {
    let joke: Joke
    let size: CGFloat

    var body: some View {
        Image(systemName: joke.categoryIcon)
            .font(.system(size: size * 0.45))
            .foregroundStyle(.tint)
            .frame(width: size, height: size)
            .background(.tint.opacity(0.15), in: Circle())
            .accessibilityHidden(true)
    }
}
