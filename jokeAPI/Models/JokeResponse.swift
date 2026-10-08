import Foundation

struct JokeResponse: Decodable {
    let amount: Int
    let jokes: [Joke]
}

struct JokeAPIErrorResponse: Decodable {
    let code: Int
    let message: String
}
