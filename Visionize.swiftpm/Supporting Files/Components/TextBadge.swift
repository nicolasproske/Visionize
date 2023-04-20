import SwiftUI

/// `TextBadge is a SwiftUI view that displays a symbol, a title and an optional checkmark icon.
struct TextBadge: View {
    // The symbol to be displayed.
    let symbol: String
    
    // The title to be displayed.
    let title: String
    
    // The color of the badge.
    let color: Color
    
    // Indicates whether the badge is active.
    let isActive: Bool
    
    // Indicates whether the badge should display a checkmark icon.
    let checked: Bool
    
    var body: some View {
        if isActive {
            content
                .background(color.opacity(0.15))
                .cornerRadius(8)
        } else {
            content
        }
    }
    
    private var content: some View {
        HStack(spacing: 10) {
            // The symbol of the badge.
            Image(systemName: symbol)
                .foregroundColor(isActive ? color : .gray)
            
            // The title of the badge.
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
            
            // The checkmark icon, if required.
            if checked {
                Image(systemName: "checkmark")
                    .font(.system(size: 10, weight: .heavy))
                    .foregroundColor(isActive ? .green : .gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 15)
        .padding(.vertical, 16)
    }
}
