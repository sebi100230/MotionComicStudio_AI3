import SwiftUI

struct GenerateView: View {
    let pages: [UIImage]
    
    @AppStorage("personalUseOnly") var personalUseOnly = true
    
    @State private var status = "Preparing…"
    @State private var finished = false
    @State private var script: String = ""
    @State private var warnings: [String] = []
    @State private var userAcceptedWarnings = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Personal Use enforcement
            if !personalUseOnly {
                Text("⚠️ Enable Personal Use Only mode to continue.")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Spacer()
            } else {
                
                // Show progress while generating
                if !finished {
                    ProgressView()
                    Text(status)
                        .font(.subheadline)
                }
                
                // Show warnings if any
                if !warnings.isEmpty && !userAcceptedWarnings {
                    VStack(spacing: 12) {
                        Text("⚠️ Copyright Warning")
                            .font(.headline)
                        
                        Text("Detected references: \(warnings.joined(separator: ", "))")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                        
                        Text("You confirm that you own the rights to this content and are using this app for personal use only.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                        
                        Button("I Understand & Accept") {
                            userAcceptedWarnings = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
                
                // Show script once finished and warnings accepted
                if finished && (warnings.isEmpty || userAcceptedWarnings) {
                    ScrollView {
                        Text(script)
                            .padding()
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
        .padding()
        .task {
            await generate()
        }
    }
    
    func generate() async {
        // Check personal use mode
        guard personalUseOnly else {
            status = "Enable Personal Use Only to continue"
            return
        }
        
        do {
            status = "Generating script with AI…"
            
            // Call updated AIService
            let response = try await AIService.shared.generateScript(from: pages)
            
            script = response.script
            warnings = response.warnings
            
            status = "Done!"
            finished = true
        } catch {
            status = "Error generating script"
            print(error)
        }
    }
}
