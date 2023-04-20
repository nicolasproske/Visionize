import SwiftUI

/// `LessonExerciseDescriptionCell is a SwiftUI view that displays an exercise description within a lesson.
struct LessonExerciseDescriptionCell: View {
    // A property that represents the current lesson
    let lesson: Lesson
    
    // The description of the exercise.
    let lessonExerciseDescription: LessonExerciseDescription
    
    var body: some View {
        HStack(spacing: 10) {
            // A vertical divider in the lesson color.
            VerticalDivider(color: lesson.color, width: 4.0)
                .cornerRadius(2)
            
            // A vertical stack that contains the exercise caption and description.
            VStack(alignment: .leading, spacing: 5) {
                Text("Exercise: \(lesson.caption)")
                    .fontWeight(.semibold)
                    .foregroundColor(lesson.color)
                
                Text(.init(lessonExerciseDescription.content))
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
