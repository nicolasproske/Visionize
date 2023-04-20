import SwiftUI

/// `HorizontalDivider` is a SwiftUI view that displays a horizontal line with a specified color.
struct HorizontalDivider: View {
    // The color of the line. The default color is the system's secondary background color.
    var color = Color(.secondarySystemBackground)
    
    var body: some View {
        // Create a rectangle that fills the entire horizontal space available, with a fixed height of 3 points and with the specified color.
        Rectangle()
            .frame(maxWidth: .infinity, minHeight: 3, maxHeight: 3)
            .foregroundColor(color)
    }
}
