import SwiftUI

/// `RoundedCorner is a SwiftUI shape that creates a path with rounded corners.
struct RoundedCorner: Shape {
    // The radius of the corners. By default, the radius is set to infinity, which means that the corners are completely rounded.
    var radius: CGFloat = .infinity
    
    // The corners to be rounded. By default, all corners are rounded.
    var corners: UIRectCorner = .allCorners
    
    // Creates the path with rounded corners.
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
