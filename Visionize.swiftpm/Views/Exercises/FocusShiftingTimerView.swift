import AVFoundation
import SwiftUI

struct FocusShiftingTimerView: View {
    // The duration of each symbol's highlight in seconds.
    var symbolSwitchDuration = 2
    
    // A closure that will be called when the timer reaches 30 seconds.
    let finishAction: () -> Void
    
    // Boolean indicating whether the timer is currently active.
    @State private var timerActive = false
    
    // Elapsed time in seconds since the timer was started.
    @State private var elapsedTime = 0
    
    // Index of the currently highlighted symbol.
    @State private var highlightedSymbol: Int = 1
    
    // A timer that updates every second.
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // Two symbols (a thumbs up and a 3D stack) that alternate highlighting.
            HStack {
                symbolImage(systemName: "hand.thumbsup.fill", highlighted: timerActive && highlightedSymbol == 0)
                symbolImage(systemName: "square.stack.3d.forward.dottedline.fill", highlighted: timerActive && highlightedSymbol == 1)
            }
            .onReceive(timer) { _ in
                // When the timer updates and if the timer is active, update the timer.
                guard timerActive else { return }
                updateTimer()
            }
            
            // Elapsed time and focus instructions.
            VStack(spacing: 4) {
                Text("\(30 - elapsedTime) seconds left")
                    .font(.system(size: 24, weight: .bold))
                
                if timerActive {
                    
                    Text("Focus your **\(highlightedSymbol == 0 ? "thumb" : "distant object")**")
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

extension FocusShiftingTimerView {
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
        highlightedSymbol = 0
    }
    
    /// Updates the timer.
    private func updateTimer() {
        elapsedTime += 1
        
        // Play a sound every second except for the multiples of the symbol switch duration.
        if elapsedTime % symbolSwitchDuration != 0 {
            AudioServicesPlaySystemSound(1105)
        }
        
        // Switch the highlighted symbol and play a sound at each multiple of the symbol switch duration.
        if elapsedTime < 30 && elapsedTime % symbolSwitchDuration == 0 {
            highlightedSymbol = (highlightedSymbol + 1) % 2
            AudioServicesPlaySystemSound(1103)
        }
        
        // If the timer has reached 30 seconds, stop the timer and call the finish action.
        if elapsedTime >= 30 {
            stopTimer()
            finishAction()
        }
    }
}
