import Foundation

/// Defining a protocol named `LessonElementProtocol` that adopts the `Identifiable` protocol.
/// It requires a property named `id` of type `UUID`.
/// This protocol can be used as a type constraint for any `LessonElement` class that needs to conform to the `Identifiable` protocol and has a unique `UUID`.
protocol LessonElementProtocol: Identifiable {
    var id: UUID { get }
}

/// Defining a class named `LessonElement` that adopts the `LessonElementProtocol`.
class LessonElement: LessonElementProtocol {
    let id: UUID
    
    var paddingTop: Bool
    
    init(paddingTop: Bool) {
        self.id = UUID()
        self.paddingTop = paddingTop
    }
}
