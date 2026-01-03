import SwiftUI

struct RightsConfirmationView: View {
    let pages: [UIImage]
    @State private var confirmed = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Content Ownership")
                .font(.title2)
                .bold()

            Text("""
You confirm that you own or have permission to use all uploaded content.
This app does not support copyrighted franchises.
""")
                .font(.footnote)
                .multilineTextAlignment(.center)

            Toggle("I own the rights to this content", isOn: $confirmed)

            NavigationLink("Generate Motion Comic") {
                GenerateView(pages: pages)
            }
            .disabled(!confirmed)
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}
