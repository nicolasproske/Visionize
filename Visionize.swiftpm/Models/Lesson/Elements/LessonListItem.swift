import Foundation

/// Defining a class named `LessonListItem` that inherits from the `LessonElement` class.
class LessonListItem: LessonElement {
    let content: String
    
    init(content: String, paddingTop: Bool = false) {
        self.content = content
        super.init(paddingTop: paddingTop)
    }
}
