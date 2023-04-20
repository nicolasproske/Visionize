import AVFoundation
import SwiftUI

struct EyeRotationTimerView: View {
    // A closure that will be called when the timer reaches 30 seconds.
    let finishAction: () -> Void
    
    // Boolean indicating whether the timer is currently active.
    @State private var timerActive = false
    
    // Elapsed time in seconds since the timer was started.
    @State private var elapsedTime = 0
    
    // The current angle of the arrow image.
    @State private var angle: Double = 0
    
    // The current direction of rotation for the arrow image (either 1 or -1).
    @State private var rotationDirection: Double = 1
    
    // The duration of the rotation animation in seconds.
    private let rotationDuration = 15
    
    // A timer that updates every second.
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // Arrow image that rotates.
            Image(systemName: "arrow.\(elapsedTime >= 15 ? "counter" : "")clockwise.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(angle))
                .foregroundColor(timerActive ? Color.green : .gray)
                .padding(12)
                .background(timerActive ? Color.green.opacity(0.2) : .gray.opacity(0.1))
                .cornerRadius(12)
                .onReceive(timer) { _ in
                    // When the timer updates and if the timer is active, update the timer to rotate the image.
                    guard timerActive else { return }
                    updateTimer()
                }
            
            // Elapsed time and rotation instructions.
            VStack(spacing: 4) {
                Text("\(30 - elapsedTime) seconds left")
                    .font(.system(size: 24, weight: .bold))
                
                if timerActive {
                    Text("Rotate your eyes **\(elapsedTime >= 15 ? "counterclockwise" : "clockwise")**")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 15)
            
            // Buttons for starting, stopping, and resetting the timer.
            HStack {
                if timerActive {
                    Button {
                        stopTimer()
                    } label: {
                        Text("Stop")
                            .actionButton(color: .gray)
                    }
                } else {
                    Button {
                        startTimer()
                    } label: {
                        Text("Start")
                            .actionButton(color: .green)
                    }
                }
                
                if !timerActive && elapsedTime > 0 {
                    Button {
                        resetTimer()
                    } label: {
                        Text("Reset")
                            .actionButton(color: .red)
                    }
                }
            }
        }
    }
}

// MARK: - Methods

extension EyeRotationTimerView {
    /// Starts the timer.
    private func startTimer() {
        timerActive = true
    }
    
    /// Stops the timer.
    private func stopTimer() {
        timerActive = false
    }
    
    /// Resets the timer.
    private func resetTimer() {
        timerActive = false
        elapsedTime = 0
        angle = 0
        rotationDirection = 1
    }
    
    /// Updates the timer.
    private func updateTimer() {
        elapsedTime += 1
        
        // Play a sound every second except for the multiples of the rotation duration.
        if elapsedTime % rotationDuration != 0 {
            AudioServicesPlaySystemSound(1105)
        }
        
        // Reverse the rotation direction and play a sound at each multiple of the rotation duration.
        if elapsedTime < 30 && elapsedTime % rotationDuration == 0 {
            rotationDirection *= -1
            AudioServicesPlaySystemSound(1103)
        }
        
        // Rotate the arrow image.
        withAnimation(.easeIn(duration: 0.15)) {
            angle += 360 / Double(rotationDuration) * rotationDirection
        }
        
        // If the timer has reached 30 seconds, reset the timer and call the finish action.
        if elapsedTime >= 30 {
            resetTimer()
            finishAction()
        }
    }
}
