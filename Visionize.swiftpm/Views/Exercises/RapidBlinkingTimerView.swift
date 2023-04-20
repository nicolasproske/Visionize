import AVFoundation
import SwiftUI

struct RapidBlinkingTimerView: View {
    // A closure that will be called when the timer reaches 15 seconds.
    let finishAction: () -> Void
    
    // Boolean indicating whether the timer is currently active.
    @State private var timerActive = false
    
    // Elapsed time in seconds since the timer was started.
    @State private var elapsedTime = 0
    
    // Boolean indicating whether the symbol should be highlighted.
    @State private var symbolHighlighted = false
    
    // The duration of each symbol's highlight in seconds.
    private let highlightDuration = 5
    
    // A timer that updates every second.
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // An eye symbol that alternates highlighting and not highlighting.
            symbolImage(systemName: symbolHighlighted ? "eye.fill" : "eye.slash.fill", highlighted: timerActive && symbolHighlighted)
                .onReceive(timer) { _ in
                    // When the timer updates and if the timer is active, update the timer.
                    guard timerActive else { return }
                    updateTimer()
                }
            
            // Elapsed time and blinking instructions.
            VStack(spacing: 4) {
                Text("\(15 - elapsedTime) seconds left")
                    .font(.system(size: 24, weight: .bold))
                
                if timerActive {
                    Group {
                        if symbolHighlighted {
                            Text("Start blinking rapidly")
                        } else {
                            Text("Take a short break")
                        }
                    }
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

extension RapidBlinkingTimerView {
    /// Returns a highlighted or unhighlighted symbol image.
    private func symbolImage(systemName: String, highlighted: Bool) -> some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(highlighted ? Color.green : .gray)
            .padding(12)
            .background(highlighted ? Color.green.opacity(0.2) : .gray.opacity(0.1))
            .cornerRadius(12)
    }
    
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
        symbolHighlighted = false
    }
    
    /// Updates the timer.
    private func updateTimer() {
        elapsedTime += 1
        
        // Play a sound every second except for multiples of the highlight duration.
        if elapsedTime % highlightDuration != 0 {
            AudioServicesPlaySystemSound(1105)
        } else {
            // Play a sound at each highlight.
            if elapsedTime < 15 {
                AudioServicesPlaySystemSound(1103)
            }
        }
        
        // Alternate highlighting and not highlighting the symbol.
        symbolHighlighted = (elapsedTime % (highlightDuration * 2)) < highlightDuration
        
        // If the timer has reached 15 seconds, stop the timer and call the finish action.
        if elapsedTime >= 15 {
            stopTimer()
            finishAction()
        }
    }
}
