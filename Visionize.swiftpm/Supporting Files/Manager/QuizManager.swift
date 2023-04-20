import Foundation

/// `QuizManager` is an ObservableObject that manages the state and behavior of the quiz in the app.
class QuizManager: ObservableObject {
    // The currently selected question.
    @Published var currentQuestion: Question = .first
    
    // A flag that indicates if the quiz has been finished.
    @Published var isFinished: Bool = false
    
    /// Checks if the current question is answered correctly.
    func isCurrentQuestionCorrect(answer: Answer) -> Bool {
        if let correctAnswer = currentQuestion.answers.first(where: { $0.isCorrect }) {
            if correctAnswer.text == answer.text {
                return true
            }
        }
        
        return false
    }
    
    /// Switches to the next question.
    func nextQuestion() {
        if let index = Question.allCases.firstIndex(of: currentQuestion) {
            if index < (Question.allCases.count - 1) {
                currentQuestion = Question.allCases[index + 1]
            } else {
                isFinished = true
            }
        }
    }
    
    /// Resets the quiz.
    func reset() {
        currentQuestion = .first
        isFinished = false
    }
}
