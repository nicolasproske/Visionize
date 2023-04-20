import SwiftUI

struct LessonExerciseView: View {
    // A property that represents the current lesson
    let lesson: Lesson
    
    // The manager for the lesson, which tracks its progress.
    @ObservedObject var lessonManager: LessonManager
    
    // The manager for the quiz, which tracks its progress and state.
    @ObservedObject var quizManager: QuizManager
    
    // The counter used for the confetti animation.
    @State private var counter: Int = 0
    
    // The interval for shifting focus during the second lesson exercise.
    @State private var shiftingFocusIntervalInSeconds: Int = 2
    
    var body: some View {
        area
            .padding(.leading, 10)
            .padding(.trailing, 30)
            .padding(.bottom, 10)
    }
    
    // A computed property that returns the exercise or quiz view for the given lesson.
    private var area: some View {
        Group {
            switch lesson {
            case .introduction:
                introductionExercise
            case .first:
                firstLessonExercise
            case .second:
                secondLessonExercise
            case .third:
                thirdLessonExercise
            case .quiz:
                quizExercise
            }
        }
        .confettiCannon(counter: $counter)
    }
    
    // MARK: - Introduction
    
    // A computed property that returns the exercise view for the introduction lesson.
    private var introductionExercise: some View {
        ExerciseDetail(
            emoji: "🕹",
            title: "Here's your exercise area",
            description: "In this area, exercises will be waiting for you to master. Once you complete an exercise, the percentage in the top corner will increase.",
            showBottom: false
        ) {
            continueResetLessonButton
        } bottom: {}
    }
    
    // MARK: - Lesson 1
    
    // A computed property that returns the exercise view for the first lesson.
    private var firstLessonExercise: some View {
        ExerciseDetail(
            emoji: "👀",
            title: "Practise eye rotations",
            description: "The exercise lasts for 30 seconds. Rotate your eyes clockwise for the first 15 seconds, then counterclockwise for the remaining 15 seconds.",
            showBottom: !lessonManager.isFinished(lesson: lesson)
        ) {
            if lessonManager.isFinished(lesson: lesson) {
                continueResetLessonButton
            }
        } bottom: {
            EyeRotationTimerView {
                finishExercise()
            }
        }
    }
    
    // MARK: - Lesson 2
    
    // A computed property that returns the exercise view for the second lesson.
    private var secondLessonExercise: some View {
        ExerciseDetail(emoji: "🔬", title: "Practise focus shifting", description: "The exercise lasts for 30 seconds. Change the focus every time the highlighted symbol changes below. Select the speed that works best for you below.", showBottom: !lessonManager.isFinished(lesson: lesson)) {
            if lessonManager.isFinished(lesson: lesson) {
                continueResetLessonButton
            } else {
                Picker("Geschwindigkeit", selection: $shiftingFocusIntervalInSeconds) {
                    Text("Slow").tag(3)
                    Text("Normal").tag(2)
                    Text("Fast").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 350)
                .padding(.horizontal, 50)
            }
        } bottom: {
            FocusShiftingTimerView(symbolSwitchDuration: shiftingFocusIntervalInSeconds) {
                finishExercise()
            }
        }
    }
    
    // MARK: - Lesson 3
    
    // A computed property that returns the exercise view for the third lesson.
    private var thirdLessonExercise: some View {
        ExerciseDetail(emoji: "⚡️", title: "Practise rapid blinking", description: "The exercise lasts for 15 seconds. Take a five second break after each blink session.", showBottom: !lessonManager.isFinished(lesson: lesson)) {
            if lessonManager.isFinished(lesson: lesson) {
                continueResetLessonButton
            }
        } bottom: {
            RapidBlinkingTimerView() {
                finishExercise()
            }
        }
    }
    
    // MARK: - Quiz
    
    // A computed property that returns the exercise view for the quiz.
    private var quizExercise: some View {
        ExerciseDetail(emoji: "🏆", title: "Challenge yourself", description: "Put your learned knowledge to the test by answering the questions below.", showBottom: !quizManager.isFinished) {
            if quizManager.isFinished {
                continueResetQuizButton
            }
        } bottom: {
            QuizView(quizManager: quizManager) {
                finishExercise()
            }
        }
    }
    
    // A computed property that returns a button to continue or reset the lesson, depending on its state.
    private var continueResetLessonButton: some View {
        ExerciseButton(isFinished: lessonManager.isFinished(lesson: lesson), actionTitle: "Press to continue") {
            finishExercise()
        } resetAction: {
            lessonManager.resetLesson(lesson: lesson)
        }
    }
    
    // A computed property that returns a button to continue or reset the quiz, depending on its state.
    private var continueResetQuizButton: some View {
        ExerciseButton(isFinished: quizManager.isFinished, actionTitle: "Press to continue") {
            finishExercise()
        } resetAction: {
            quizManager.reset()
        }
    }
}

// MARK: - Methods

extension LessonExerciseView {
    // A private function that finishes the current exercise or quiz, increments the counter for the confetti animation, marks the current lesson as finished, and moves on to the next lesson.
    private func finishExercise() {
        lessonManager.finishLesson(lesson: lesson)
        counter += 1
        lessonManager.nextLesson()
    }
}

// MARK: - SubViews

extension LessonExerciseView {
    private struct ExerciseButton: View {
        // A boolean that indicates whether the exercise or quiz has been finished or not.
        let isFinished: Bool
        
        // A string that contains the title for the action button, such as "Continue".
        let actionTitle: String
        
        // A closure that is executed when the button is pressed to continue the exercise or quiz.
        let continueAction: () -> Void
        
        // A closure that is executed when the button is pressed to reset the exercise or quiz.
        let resetAction: () -> Void
        
        var body: some View {
            if isFinished {
                Button {
                    resetAction()
                } label: {
                    VStack(spacing: 2) {
                        Text("Great, well done!")
                        Text("Press to restart")
                            .font(.system(size: 10, weight: .bold))
                            .textCase(.uppercase)
                            .opacity(0.6)
                    }
                    .actionButton(color: .gray)
                }
            } else {
                Button {
                    continueAction()
                } label: {
                    Text(actionTitle.isEmpty ? "Continue" : actionTitle)
                        .actionButton(color: .green)
                }
            }
        }
    }
    
    private struct ExerciseDetail<Top: View, Bottom: View>: View {
        // An environment variable that provides the current color scheme.
        @Environment(\.colorScheme) private var colorScheme
        
        // A string that contains the emoji for the exercise or quiz.
        let emoji: String
        
        // A string that contains the title for the exercise or quiz.
        let title: String
        
        // A string that contains the description for the exercise or quiz.
        let description: String
        
        // A string that contains the title for the exercise area indicator.
        var indicatorTitle: String = "Exercise Area"
        
        // A boolean that indicates whether the bottom section of the exercise detail should be displayed or not.
        var showBottom: Bool = true
        
        // A builder for the top view of the exercise detail section.
        @ViewBuilder var top: Top
        
        // A builder for the bottom view of the exercise detail section.
        @ViewBuilder var bottom: Bottom
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    ZStack(alignment: .top) {
                        VStack {
                            Spacer()
                            
                            Text(emoji)
                                .font(.system(size: 32))
                                .padding(10)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                            
                            VStack(spacing: 10) {
                                Text(title)
                                    .font(.system(size: 20, weight: .bold))
                                
                                Text(description)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                            
                            top
                            
                            Spacer()
                        }
                        
                        Text(indicatorTitle)
                            .font(.system(size: 10, weight: .heavy))
                            .textCase(.uppercase)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                    }
                    
                    if showBottom {
                        VStack {
                            Spacer()
                            bottom
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }
        }
    }
}
