import Foundation

/// Defining a class named `LessonText` that inherits from the `LessonElement` class.
class LessonText: LessonElement {
    let content: String
    
    init(content: String, paddingTop: Bool = false) {
        self.content = content
        super.init(paddingTop: paddingTop)
    }
}
