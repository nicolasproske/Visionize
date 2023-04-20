import Foundation

/// Defining an enumeration named `Question` that adopts the `Identifiable` protocol and is `CaseIterable`.
/// The enumeration cases represent the different questions in the quiz lesson of the app.
/// Each case has a corresponding `id`, `text` and `answers`.
/// `id` is a string that represents the raw value of the enumeration case.
/// `text` is a string that represents the text that corresponds to the question.
/// `elements` is an array of `Answer` objects that represent the different answers of each question.
enum Question: String, Identifiable, CaseIterable {
    case first, second, third
    
    var id: String {
        return rawValue
    }
    
    var text: String {
        switch self {
        case .first:
            return "In what situation do your eyes need to often change focus?"
        case .second:
            return "What's it called if your eyes feel tired and strained?"
        case .third:
            return "What coordination is essential for many daily activities?"
        }
    }
    
    var answers: [Answer] {
        switch self {
        case .first:
            return [Answer(text: "While driving a car", isCorrect: true), Answer(text: "When watching TV", isCorrect: false), Answer(text: "While reading the newspaper", isCorrect: false)]
        case .second:
            return [Answer(text: "Eye irritation", isCorrect: false), Answer(text: "Eye fatigue", isCorrect: true), Answer(text: "Eye strain", isCorrect: false)]
        case .third:
            return [Answer(text: "Ear-hand coordination", isCorrect: false), Answer(text: "Eye-ear coordination", isCorrect: false), Answer(text: "Eye-hand coordination", isCorrect: true)]
        }
    }
}
