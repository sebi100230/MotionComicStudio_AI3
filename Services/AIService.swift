import Foundation
import UIKit

// Updated to include warnings from the backend
struct ScriptResponse: Codable {
    let script: String
    let warnings: [String]
}

class AIService {
    static let shared = AIService()
    
    // Replace with your deployed backend URL
    let backendURL = "https://YOUR_BACKEND_URL"

    /// Generate script from pages
    func generateScript(from pages: [UIImage]) async throws -> ScriptResponse {
        
        // Convert images to simple descriptions (or placeholders for now)
        // In real app, you could extract text via OCR or let user type captions
        let pageDescriptions = pages.enumerated().map { "Page \($0.offset + 1)" }

        guard let url = URL(string: "\(backendURL)/generate-script") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Send pages as JSON
        let body = ["pages": pageDescriptions]
        request.httpBody = try JSONEncoder().encode(body)

        // Make network call
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Decode response (script + warnings)
        let decoded = try JSONDecoder().decode(ScriptResponse.self, from: data)
        
        return decoded
    }
}
