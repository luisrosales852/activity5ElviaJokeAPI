import Foundation

struct Joke: Identifiable, Decodable, Hashable {
    let id: Int
    let category: String
    let type: JokeType
    let joke: String?
    let setup: String?
    let delivery: String?
    let flags: Flags
    let safe: Bool
    let lang: String

    enum JokeType: String, Decodable {
        case single
        case twopart
    }

    struct Flags: Decodable, Hashable {
        let nsfw: Bool
        let religious: Bool
        let political: Bool
        let racist: Bool
        let sexist: Bool
        let explicit: Bool
    }

    var headline: String {
        joke ?? setup ?? "Untitled joke"
    }

    var punchline: String? {
        type == .twopart ? delivery : nil
    }

    var categoryIcon: String {
        switch category {
        case "Programming": "chevron.left.forwardslash.chevron.right"
        case "Pun":         "textformat.abc"
        case "Spooky":      "moon.stars"
        case "Christmas":   "gift"
        case "Dark":        "theatermasks"
        default:            "face.smiling"
        }
    }
}
