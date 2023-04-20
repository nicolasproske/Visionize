import SwiftUI

/// Defining an enumeration named `Lesson` that adopts the `Identifiable` protocol and is `CaseIterable`.
/// The enumeration cases represent the different lessons in the app.
/// Each case has a corresponding `id`, `symbol`, `title`, `caption`, `color` and `elements`.
/// `id` is a string that represents the raw value of the enumeration case.
/// `symbol` is a string that represents the system icon symbol name that corresponds to the lesson.
/// `title` is a string that represents the title of the lesson.
/// `caption` is a string that represents the caption of the lesson.
/// `color` is a color that represents the color of the lesson.
/// `elements` is an array of `LessonElement` objects that represent the different elements in each lesson.
enum Lesson: String, Identifiable, CaseIterable {
    case introduction, first, second, third, quiz
    
    var id: String {
        return rawValue
    }
    
    var symbol: String {
        switch self {
        case .introduction:
            return "hand.wave.fill"
        case .first:
            return "zzz"
        case .second:
            return "square.stack.3d.forward.dottedline.fill"
        case .third:
            return "eyebrow"
        case .quiz:
            return "brain.head.profile"
        }
    }
    
    var title: String {
        switch self {
        case .introduction:
            return "Welcome to Visionize"
        case .first:
            return "Reduce Eye Fatigue and Strain"
        case .second:
            return "Shifting Focus"
        case .third:
            return "Blink, Blink, Blink"
        case .quiz:
            return "Take a Challenge"
        }
    }
    
    var caption: String {
        switch self {
        case .introduction:
            return "Introduction"
        case .first:
            return "Lesson 1"
        case .second:
            return "Lesson 2"
        case .third:
            return "Lesson 3"
        case .quiz:
            return "Quiz"
        }
    }
    
    var color: Color {
        switch self {
        case .introduction:
            return .blue
        case .first:
            return .indigo
        case .second:
            return .orange
        case .third:
            return .pink
        case .quiz:
            return .green
        }
    }
    
    var elements: [LessonElement] {
        switch self {
        case .introduction:
            return [
                LessonText(content: "Our eyes are crucial as they allow us to interpret the world around us. In the upcoming three minutes, you'll discover the vital aspects of your eyes, along with playfully designed exercises to enhance your vision for a great **WWDC23**!"),
                LessonTitle(content: "Eye Training Exercises", paddingTop: true),
                LessonListItem(content: "Each lesson includes a short training exercise which is described in the section with the blue line on the left side"),
                LessonExerciseDescription(content: "Put your device in landscape orientation, activate dark mode, turn on your sounds and have fun! For now, just take a look on the right side, read the text and simply press \"Press to continue\" to complete this exercise.", paddingTop: true),
                LessonTitle(content: "Importance of Eye Care", paddingTop: true),
                LessonText(content: "Taking care of your eyes is important to maintain overall eye health. Training can help improve eye muscle strength and flexibility, reduce eye strain and prevent eye fatigue. If you experience any discomfort or pain during an exercise, please stop immediately and consult with an eye doctor.")
            ]
        case .first:
            return [
                LessonText(content: "Performing certain tasks that require intense visual focus such as constantly staring at screens or reading books can cause your eyes to feel tired and strained, which is commonly known as eye fatigue."),
                LessonText(content: "Eye rotations are a type of eye exercise that can help improve eye muscle strength, flexibility and range of motion by training specific muscles in and around the eye.", paddingTop: true),
                LessonExerciseDescription(content: "Sit back in a comfortable position and focus on a point directly in front of you. Try to make circles with your eyes as smooth and even as possible and avoid moving your head or neck.", paddingTop: true),
                LessonTitle(content: "Positive Effects", paddingTop: true),
                LessonListItem(content: "Reduced eye fatigue"),
                LessonListItem(content: "Improved eye-hand coordination: This is essential for many daily activities such as writing, reading and driving.")
            ]
        case .second:
            return [
                LessonText(content: "You may frequently come across scenarios where you need to rapidly shift your focus between objects that are nearby and distant. Here are some everyday examples:"),
                LessonListItem(content: "Driving your car"),
                LessonListItem(content: "Grocery shopping"),
                LessonListItem(content: "Copying from the blackboard"),
                LessonText(content: "The following eye exercise aims to improve your eyes' ability to quickly focus on distant objects.", paddingTop: true),
                LessonExerciseDescription(content: "Hold your thumb up at arm's length and alternate focusing between your thumb and an object in the distance.", paddingTop: true),
                LessonTitle(content: "Positive Effects", paddingTop: true),
                LessonText(content: "Regularly engaging in this exercise can yield numerous benefits:"),
                LessonListItem(content: "It can improve the speed and accuracy of eye movements, which is relevant for sports like tennis, golf or baseball"),
                LessonListItem(content: "It can aid in relaxing and strengthening your eyes")
            ]
        case .third:
            return [
                LessonText(content: "Blinking is an important part of maintaining eye health. With each blink, tears are spread over the surface of the eye, which helps it stay lubricated and not dry out. One of the common causes of dry eyes is reduced blinking, which can be caused by activities that require sustained visual attention."),
                LessonTitle(content: "The 20-20-20 Rule", paddingTop: true),
                LessonText(content: "Follow this guideline to take regular breaks from such activities:"),
                LessonListItem(content: "Look away every 20 minutes"),
                LessonListItem(content: "Focus on an object at least 20 feet away"),
                LessonListItem(content: "Look at it for at least 20 seconds"),
                LessonExerciseDescription(content: "Start by blinking your eyes rapidly, making sure to fully close and open your eyes with each blink. After a few seconds, close your eyes and let them rest for a few seconds.", paddingTop: true)
            ]
        case .quiz:
            return [
                LessonText(content: "Congratulations on completing all three lessons! Your dedication and commitment to improving your eye health is truly admirable. Keep up the great work and don't forget to make eye exercises a regular part of your routine to maintain and continue improving your visual acuity."),
                LessonExerciseDescription(content: "Lastly, don't forget to test your newly acquired knowledge with a short quiz. Enjoy and have fun!", paddingTop: true),
                LessonText(content: "I'm thrilled to hear that you learned something new. Wishing you an insightful and exciting **WWDC23**, see you there!", paddingTop: true)
            ]
        }
    }
}
