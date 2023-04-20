import SwiftUI

/// `PrimaryButtonModifier` is a SwiftUI view modifier that applies a primary style to a button.
struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .foregroundColor(.primary)
            .font(.system(size: 16, weight: .semibold))
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
    }
}
