import SwiftUI

struct LessonDetailView: View {
    // A property that represents the current lesson
    let lesson: Lesson
    
    // The manager for the current lesson
    @ObservedObject var lessonManager: LessonManager
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            HorizontalDivider()
            
            // A scroll view that contains the lesson elements
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    // Iterates over each element in the current lesson
                    ForEach(lesson.elements) { element in
                        Group {
                            // Displays the description of the current exercise
                            if let note = element as? LessonExerciseDescription {
                                LessonExerciseDescriptionCell(lesson: lesson, lessonExerciseDescription: note)
                            }
                            
                            // A horizontal stack that displays a circle icon and a list item
                            if let listItem = element as? LessonListItem {
                                HStack(alignment: .firstTextBaseline) {
                                    Circle()
                                        .fill(lesson.color)
                                        .frame(width: 5, height: 5)
                                        .offset(y: -3.5)
                                    
                                    Text(.init(listItem.content))
                                }
                                .padding(.leading, 14)
                            }
                            
                            // Displays the lesson text
                            if let text = element as? LessonText {
                                Text(.init(text.content))
                            }
                            
                            // Displays the lesson title
                            if let title = element as? LessonTitle {
                                Text(.init(title.content))
                                    .font(.system(size: 18, weight: .semibold))
                            }
                        }
                        .padding(.top, element.paddingTop ? 20 : 0)
                        .padding(.horizontal)
                        .lineSpacing(3)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.vertical, 25)
            }
            
            HorizontalDivider()
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 30)
        .padding(.trailing, 10)
        .padding(.vertical, 10)
    }
    
    // A private computed property that displays the lesson header
    private var header: some View {
        HStack(spacing: 15) {
            Image(systemName: lesson.symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(12)
                .foregroundColor(.white)
                .background(lesson.color)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(lesson.caption)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                
                Text(lesson.title)
                    .font(.system(size: 24, weight: .bold))
            }
            
            Spacer()
        }
        .padding(.bottom, 25)
        .padding(.horizontal)
    }
}
