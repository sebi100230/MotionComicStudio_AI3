import Foundation
import UIKit

struct ScriptResponse: Codable {
    let script: String
}

class AIService {
    static let shared = AIService()

    // Replace with your backend URL later
    let backendURL = "https://YOUR_BACKEND_URL"

    func generateScript(from pages: [UIImage]) async throws -> String {
        let pageDescriptions = pages.enumerated().map {
            "Page \($0.offset + 1)"
        }

        guard let url = URL(string: "\(backendURL)/generate-script") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode([
            "pages": pageDescriptions
        ])

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(ScriptResponse.self, from: data)
        return decoded.script
    }
}
