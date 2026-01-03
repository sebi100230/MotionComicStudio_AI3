import SwiftUI

struct PreviewView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Motion Comic Created 🎬")
                .font(.title)
                .bold()

            Text("Your video has been generated.")

            Image(systemName: "film")
                .resizable()
                .frame(width: 80, height: 80)

            Spacer()
        }
        .padding()
    }
}
