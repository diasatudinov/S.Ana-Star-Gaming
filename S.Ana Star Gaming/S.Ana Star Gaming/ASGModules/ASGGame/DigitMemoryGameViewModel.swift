//
//  DigitMemoryGameViewModel 2.swift
//  S.Ana Star Gaming
//
//  Created by Dias Atudinov on 12.08.2025.
//

import SwiftUI
import AVFoundation

// MARK: - ViewModel
final class DigitMemoryGameViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    enum Phase { case idle, playing, awaitingInput, failed, success, completed }

    let totalRounds: Int = 9
    let baseLength: Int = 4

    @Published private(set) var currentRound: Int = 1
    @Published private(set) var targetLength: Int = 4
    @Published private(set) var sequence: [Int] = []
    @Published var userInput: [Int] = []
    @Published private(set) var phase: Phase = .idle
    @Published private(set) var isSpeaking: Bool = false

    private let synthesizer = AVSpeechSynthesizer()
    private var utterancesLeft: Int = 0
    private let notifHaptic = UINotificationFeedbackGenerator()

    override init() {
        super.init()
        synthesizer.delegate = self
        updateTargetLength()
        prepareRound()
    }

    // Allow external configuration
    func setRound(_ round: Int) {
        currentRound = max(1, min(totalRounds, round))
        updateTargetLength()
        prepareRound()
    }

    func startOrReplayAudio() {
        guard !isSpeaking else { return }
        speakSequence()
    }

    func resetInput() {
        guard phase != .playing else { return }
        userInput.removeAll()
        if phase == .failed { phase = .awaitingInput }
    }

    func tapDigit(_ d: Int) {
        guard phase == .awaitingInput, !isSpeaking else { return }
        userInput.append(d)
        validateProgress()
    }

    func nextRoundIfPossible() {
        guard phase == .success else { return }
        advanceRound()
    }

    func restartGame() {
        currentRound = 1
        updateTargetLength()
        sequence = []
        userInput = []
        phase = .idle
        prepareRound()
    }

    private func updateTargetLength() {
        targetLength = baseLength + (currentRound - 1)
    }

    private func prepareRound() {
        userInput.removeAll()
        sequence = Self.randomDigits(length: targetLength)
        phase = .idle
    }

    private func advanceRound() {
        notifHaptic.notificationOccurred(.success)
        if currentRound >= totalRounds {
            phase = .completed
            return
        }
        currentRound += 1
        updateTargetLength()
        prepareRound()
    }

    private func validateProgress() {
        let idx = userInput.count - 1
        guard idx >= 0 && idx < sequence.count else { return }
        if userInput[idx] != sequence[idx] {
            phase = .failed
            notifHaptic.notificationOccurred(.error)
            return
        }
        if userInput.count == sequence.count {
            phase = .success
            notifHaptic.notificationOccurred(.success)
        }
    }

    private func speakSequence() {
        guard !sequence.isEmpty else { return }
        isSpeaking = true
        phase = .playing
        utterancesLeft = sequence.count

        for (i, num) in sequence.enumerated() {
            let utter = AVSpeechUtterance(string: String(num))
            utter.voice = AVSpeechSynthesisVoice(language: "en-US")
            utter.rate = 0.46
            utter.pitchMultiplier = 1.0
            utter.postUtteranceDelay = i == sequence.count - 1 ? 0.15 : 0.35
            synthesizer.speak(utter)
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        utterancesLeft = max(0, utterancesLeft - 1)
        if utterancesLeft == 0 {
            isSpeaking = false
            if phase == .playing { phase = .awaitingInput }
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        utterancesLeft = 0
        isSpeaking = false
        if phase == .playing { phase = .awaitingInput }
    }

    private static func randomDigits(length: Int) -> [Int] {
        (0..<length).map { _ in Int.random(in: 0...9) }
    }
}
