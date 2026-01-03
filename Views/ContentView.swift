import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("MotionComic Studio")
                    .font(.largeTitle)
                    .bold()

                Text("Turn your original comics into animated scenes.")
                    .multilineTextAlignment(.center)

                NavigationLink("Start New Project") {
                    UploadView()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
