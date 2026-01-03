import SwiftUI

struct PersonalUseToggleView: View {
    @AppStorage("personalUseOnly") var personalUseOnly = true

    var body: some View {
        Toggle(
            "Personal Use Only (No commercial use)",
            isOn: $personalUseOnly
        )
        .padding()
    }
}
