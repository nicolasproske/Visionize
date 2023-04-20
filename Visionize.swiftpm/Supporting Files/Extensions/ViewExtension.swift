import SwiftUI

extension View {
    /// A custom modifier that applies a rounded corner shape to the view.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /// A custom modifier that applies a primary button style to the view.
    func primaryButton() -> some View {
        modifier(PrimaryButtonModifier())
    }
    
    /// A custom modifier that applies an action button style with a specified color to the view.
    func actionButton(color: Color = .blue) -> some View {
        modifier(ActionButtonModifier(color: color))
    }
}
