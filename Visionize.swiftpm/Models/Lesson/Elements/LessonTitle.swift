import Foundation

/// Defining a class named `LessonTitle` that inherits from the `LessonElement` class.
class LessonTitle: LessonElement {
    let content: String
    
    init(content: String, paddingTop: Bool = false) {
        self.content = content
        super.init(paddingTop: paddingTop)
    }
}
