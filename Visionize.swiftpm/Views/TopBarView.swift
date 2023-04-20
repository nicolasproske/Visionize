import SwiftUI

struct TopBarView: View {
    // The manager for the lesson, which tracks its progress.
    @ObservedObject var lessonManager: LessonManager
    
    // An array of grid items that define the layout of the lessons section.
    private let items: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    
    var body: some View {
        HStack {
            lessonsSection
            totalProgressIndicator
        }
        .padding(.horizontal, 30)
        .padding(.top, 10)
        .background(Color(.secondarySystemBackground))
    }
    
    // A computed property that returns a view with the lessons and their status.
    private var lessonsSection: some View {
        LazyVGrid(columns: items, spacing: 10) {
            ForEach(Lesson.allCases) { lesson in
                Button {
                    lessonManager.switchLesson(to: lesson)
                } label: {
                    VStack(spacing: 10) {
                        TextBadge(symbol: lesson.symbol, title: lesson.caption, color: lesson.color, isActive: lessonManager.isActive(lesson: lesson), checked: lessonManager.isFinished(lesson: lesson))
                        
                        HorizontalDivider(color: lesson.color)
                            .opacity(lessonManager.isActive(lesson: lesson) ? 1 : 0)
                            .cornerRadius(1.5, corners: [.topLeft, .topRight])
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    // A computed property that returns a view with the the overall progress of the user.
    @ViewBuilder private var totalProgressIndicator: some View {
        if #available(iOS 16.0, *) {
            Gauge(value: lessonManager.progress, in: 0.0...100.0) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.green)
            } currentValueLabel: {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text(Int(lessonManager.progress), format: .number)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Text("%")
                        .font(.system(size: 12, weight: .semibold))
                }
            }
            .gaugeStyle(.accessoryCircular)
            .tint(.green)
            .scaleEffect(0.7)
            .padding(.bottom, 10)
        }
    }
}
