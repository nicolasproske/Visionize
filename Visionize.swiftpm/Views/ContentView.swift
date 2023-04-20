import SwiftUI

struct ContentView: View {
    // State object that manages the current lesson
    @StateObject private var lessonManager = LessonManager()
    
    // State object that manages the quiz questions and answers
    @StateObject private var quizManager = QuizManager()
    
    var body: some View {
        VStack(spacing: 0) {
            // Displays the top bar view with all lessons and the user progress
            TopBarView(lessonManager: lessonManager)
            
            HStack(spacing: 0) {
                // Displays the current lesson details
                LessonDetailView(lesson: lessonManager.currentLesson, lessonManager: lessonManager)
                
                // Displays the current lesson exercises
                LessonExerciseView(lesson: lessonManager.currentLesson, lessonManager: lessonManager, quizManager: quizManager)
            }
            .padding(.top)
            
            // Displays the navigation buttons to switch between lessons
            navigationButtons
        }
    }
    
    @ViewBuilder
    private var navigationButtons: some View {
        if let index = Lesson.allCases.firstIndex(of: lessonManager.currentLesson) {
            HStack(spacing: 20) {
                if index > 0 {
                    // Shows the previous lesson button if it exists
                    Button {
                        lessonManager.switchLesson(to: Lesson.allCases[index - 1])
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left.circle.fill")
                            
                            Text(Lesson.allCases[index - 1].caption)
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                        }
                        .foregroundColor(lessonManager.currentLesson.color)
                        .primaryButton()
                    }
                }
                
                if index < (Lesson.allCases.count - 1) {
                    // Shows the next lesson button if it exists
                    Button {
                        lessonManager.switchLesson(to: Lesson.allCases[index + 1])
                    } label: {
                        HStack {
                            Text(Lesson.allCases[index + 1].caption)
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                            
                            Image(systemName: "chevron.right.circle.fill")
                        }
                        .foregroundColor(lessonManager.currentLesson.color)
                        .primaryButton()
                    }
                }
            }
            .animation(nil, value: lessonManager.currentLesson) // Disables the animation when the lesson changes
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
        }
    }
}
