import Foundation

/// Defining a class named `LessonExerciseDescription` that inherits from the `LessonElement` class.
class LessonExerciseDescription: LessonElement {
    let content: String
    
    init(content: String, paddingTop: Bool = false) {
        self.content = content
        super.init(paddingTop: paddingTop)
    }
}
