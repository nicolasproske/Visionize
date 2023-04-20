import SwiftUI

/// `VerticalDivider` is a SwiftUI view that displays a vertical line with a specified color.
struct VerticalDivider: View {
    // The color of the line. The default color is the system's secondary background color.
    var color = Color(.secondarySystemBackground)
    
    // The width of the line. The default width is 3.0 points.
    var width = 3.0
    
    var body: some View {
        Rectangle()
            .frame(minWidth: width, maxWidth: width, maxHeight: .infinity)
            .foregroundColor(color)
    }
}
