import Foundation

/// Defining a protocol named `AnswerProtocol` that adopts the `Identifiable` and `Equatable` protocol.
/// It requires a property named `id` of type `UUID`.
/// This protocol can be used as a type constraint for any `Answer` class that needs to conform to the `Identifiable` protocol and has a unique `UUID`.
protocol AnswerProtocol: Identifiable, Equatable {
    var id: UUID { get }
}

/// Defining a class named `Answer` that implements the `AnswerProtocol` protocol.
/// It has a static method named `==` that compares two `Answer` instances for equality by checking if their `id` properties match.
class Answer: AnswerProtocol {
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    
    var text: String
    var isCorrect: Bool
    
    init(text: String, isCorrect: Bool) {
        self.id = UUID()
        self.text = text
        self.isCorrect = isCorrect
    }
}
