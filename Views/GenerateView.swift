import SwiftUI

struct GenerateView: View {
    let pages: [UIImage]
    @State private var status = "Preparing…"
    @State private var finished = false
    @State private var script: String = ""

    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
            Text(status)

            if finished {
                ScrollView {
                    Text(script)
                        .padding()
                }
            }
        }
        .padding()
        .task {
            await generate()
        }
    }

    func generate() async {
        do {
            status = "Generating script with AI…"
            script = try await AIService.shared.generateScript(from: pages)

            status = "Done!"
            finished = true
        } catch {
            status = "Error generating script"
        }
    }
}
