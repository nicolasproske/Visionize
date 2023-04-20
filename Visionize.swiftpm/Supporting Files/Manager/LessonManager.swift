import AVFoundation
import SwiftUI

/// `LessonManager` is an ObservableObject that manages the state and behavior of the lessons in the app.
class LessonManager: ObservableObject {
    // The currently selected lesson.
    @Published var currentLesson: Lesson = .introduction
    
    // The set of finished lessons.
    @Published var finishedLessons: Set<Lesson> = [] {
        didSet {
            updateProgress()
        }
    }
    
    // The progress of the user in the lessons.
    @Published var progress: CGFloat = 0.0
    
    /// Checks if the specified lesson is currently active.
    func isActive(lesson: Lesson) -> Bool {
        return currentLesson.id == lesson.id
    }
    
    /// Switches to the specified lesson.
    func switchLesson(to lesson: Lesson) {
        withAnimation(nil) {
            currentLesson = lesson
        }
    }
    
    /// Switches to the next lesson.
    func nextLesson() {
        if let index = Lesson.allCases.firstIndex(of: currentLesson) {
            if index < (Lesson.allCases.count - 1) {
                switchLesson(to: Lesson.allCases[index + 1])
            }
        }
    }
    
    /// Switches to the previous lesson.
    func previousLesson() {
        if let index = Lesson.allCases.firstIndex(of: currentLesson) {
            if index > 0 {
                switchLesson(to: Lesson.allCases[index - 1])
            }
        }
    }
    
    /// Checks if the specified lesson has been finished.
    func isFinished(lesson: Lesson) -> Bool {
        return finishedLessons.contains(lesson)
    }
    
    /// Finishes the specified lesson.
    func finishLesson(lesson: Lesson) {
        finishedLessons.insert(lesson)
        AudioServicesPlaySystemSound(1025)
    }
    
    /// Resets the specified lesson.
    func resetLesson(lesson: Lesson) {
        finishedLessons.remove(lesson)
    }
    
    /// Updates the progress of the user in the lessons.
    func updateProgress() {
        withAnimation(.easeInOut(duration: 0.15)) {
            progress = (CGFloat(finishedLessons.count) * 100.0) / CGFloat(Lesson.allCases.count)
        }
    }
}
