import SwiftUI
import PhotosUI

struct UploadView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []
    @State private var goNext = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Upload Your Comic Pages")
                .font(.title2)

            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 10,
                matching: .images
            ) {
                Label("Select Images", systemImage: "photo.on.rectangle")
            }

            Button("Continue") {
                loadImages()
            }
            .disabled(selectedItems.isEmpty)

            NavigationLink(
                "",
                destination: RightsConfirmationView(pages: images),
                isActive: $goNext
            )
        }
        .padding()
    }

    func loadImages() {
        images.removeAll()

        Task {
            for item in selectedItems {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    images.append(image)
                }
            }
            goNext = true
        }
    }
}
