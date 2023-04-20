import SwiftUI

/// `ActionButtonModifier` is a SwiftUI view modifier that applies a style to a button.
struct ActionButtonModifier: ViewModifier {
    // The color of the button.
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .foregroundColor(color)
            .font(.system(size: 16, weight: .semibold))
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(color.opacity(0.2))
            .clipShape(Capsule())
    }
}
