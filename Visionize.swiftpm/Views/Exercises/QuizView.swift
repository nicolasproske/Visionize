import AVFoundation
import SwiftUI

struct QuizView: View {
    // Observed object that manages the quiz questions and answers
    @ObservedObject var quizManager: QuizManager
    
    // A closure that will be called when the quiz is completed.
    let finishAction: () -> Void
    
    // Boolean value that indicates whether the solution to the current question should be displayed
    @State private var showSolution: Bool = false
    
    // Boolean value that indicates whether the selected answer is incorrect
    @State private var showError: Bool = false
    
    var body: some View {
        VStack {
            // Text that displays the current question number and the total number of questions
            Text("Question \((Question.allCases.firstIndex(of: quizManager.currentQuestion) ?? 0) + 1) of \(Question.allCases.count)")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 2)
            
            // Text that displays the current quiz question
            Text(quizManager.currentQuestion.text)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 15)
            
            // Iterates over the answer options for the current question and displays them as a button
            ForEach(quizManager.currentQuestion.answers) { answer in
                Button {
                    checkAnswer(answer: answer)
                } label: {
                    // Text that displays the answer text
                    Text(answer.text)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .actionButton(color: getButtonColor(answer: answer))
                }
                .disabled(showSolution || showError) // Disables the button if the solution is being shown or an error is being shown
            }
        }
        .padding(.horizontal, 50)
        .modifier(Shake(animatableData: showError ? 1 : 0)) // Applies a horizontal shake animation to the view when showError is true
        .animation(showError ? Animation.linear(duration: 0.2).repeatCount(1) : .none, value: showError) // Applies a linear animation to the view when showError is true and repeats once
    }
}

// MARK: - Methods

extension QuizView {
    /// Returns the color for the answer button based on whether the solution should be displayed or the selected answer is incorrect
    private func getButtonColor(answer: Answer) -> Color {
        if showSolution {
            // If the solution is being shown and the current answer is correct, return green
            if quizManager.isCurrentQuestionCorrect(answer: answer) {
                return .green
            }
        } else if showError {
            // If an error is being shown, return red
            return .red
        }
        
        // Otherwise, return gray
        return .gray
    }
    
    // Checks whether the selected answer is correct or not
    private func checkAnswer(answer: Answer) {
        if quizManager.isCurrentQuestionCorrect(answer: answer) {
            // If the answer is correct, show the solution, play a sound effect, wait for 1.5 seconds, hide the solution, move to the next question and call finishAction if the quiz is completed
            showSolution = true
            AudioServicesPlaySystemSound(1111)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showSolution = false
                quizManager.nextQuestion()
                
                if quizManager.isFinished {
                    finishAction()
                }
            }
        } else {
            // If the answer is incorrect, show an error, play a sound effect, wait for 0.75 seconds, and hide the error
            showError = true
            AudioServicesPlaySystemSound(1053)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                showError = false
            }
        }
    }
}

// MARK: - Other

extension QuizView {
    // A private struct that defines an effect that applies a horizontal shake animation to a view.
    private struct Shake: GeometryEffect {
        var amount: CGFloat = 8
        var shakesPerUnit: CGFloat = 3
        var animatableData: CGFloat
        
        func effectValue(size: CGSize) -> ProjectionTransform {
            let translation = amount * sin(animatableData * .pi * shakesPerUnit)
            return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
        }
    }
}
