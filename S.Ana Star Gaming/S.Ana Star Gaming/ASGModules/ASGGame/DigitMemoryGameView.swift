//
//  DigitMemoryGameViewModel.swift
//  S.Ana Star Gaming
//
//
import SwiftUI
import AVFoundation


struct DigitMemoryGameView: View {
    @StateObject private var vm = DigitMemoryGameViewModel()

    var body: some View {
        VStack(spacing: 16) {
            header
            instructions
            inputStrip
            controls
            keypad
            footer
        }
        .padding(20)
        .animation(.easeInOut, value: vm.phase)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Раунд \(vm.currentRound) из \(vm.totalRounds)")
                    .font(.title3).bold()
                Text("Длина: \(vm.targetLength) цифр")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            PhaseBadge(phase: vm.phase)
        }
    }

    private var instructions: some View {
        VStack(alignment: .leading, spacing: 8) {
            switch vm.phase {
            case .idle:
                Text("Press 'Play' to hear the sequence.")
            case .playing:
                Text("Listening… Input disabled.")
            case .awaitingInput:
                Text("Enter the sequence you heard.")
            case .failed:
                Text("Incorrect. Reset or replay audio.")
                    .foregroundColor(.red)
            case .success:
                Text("Correct! Proceed to next round.")
                    .foregroundColor(.green)
            case .completed:
                Text("Well done! You finished the game.")
                    .foregroundColor(.green)
            }
        }
        .font(.callout)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var inputStrip: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(vm.userInput.indices, id: \.self) { idx in
                    Text("\(vm.userInput[idx])")
                        .font(.title2).bold()
                        .frame(width: 44, height: 44)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                }
                if vm.userInput.isEmpty {
                    Text("input…")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 6)
        }
        .frame(height: 56)
    }

    private var controls: some View {
        HStack(spacing: 12) {
            Button {
                vm.startOrReplayAudio()
            } label: {
                Label(vm.phase == .idle ? "Play" : "Replay", systemImage: "speaker.wave.2.fill")
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isSpeaking)

            Button(role: .destructive) {
                vm.resetInput()
            } label: {
                Label("Reset", systemImage: "arrow.counterclockwise")
            }
            .buttonStyle(.bordered)

            Spacer()

            if vm.phase == .success {
                Button {
                    vm.nextRoundIfPossible()
                } label: {
                    Label(vm.currentRound == vm.totalRounds ? "Finish" : "Next", systemImage: "checkmark.circle.fill")
                }
                .buttonStyle(.borderedProminent)
            }
            if vm.phase == .completed {
                Button {
                    vm.restartGame()
                } label: {
                    Label("Play Again", systemImage: "gobackward")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    private var keypad: some View {
        VStack(spacing: 10) {
            ForEach([[1,2,3],[4,5,6],[7,8,9]], id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { n in
                        digitKey(n)
                    }
                }
            }
            HStack(spacing: 10) {
                Spacer(minLength: 0)
                digitKey(0)
                Spacer(minLength: 0)
            }
        }
        .opacity(vm.phase == .playing ? 0.4 : 1)
        .disabled(vm.phase == .playing)
    }

    private func digitKey(_ n: Int) -> some View {
        Button {
            vm.tapDigit(n)
        } label: {
            Text("\(n)")
                .font(.title2).bold()
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(RoundedRectangle(cornerRadius: 14).fill(Color(.tertiarySystemFill)))
        }
        .buttonStyle(.plain)
        .disabled(vm.isSpeaking || !(vm.phase == .awaitingInput || vm.phase == .failed))
    }

    private var footer: some View {
        VStack(spacing: 4) {
            Group {
                if vm.phase == .awaitingInput || vm.phase == .failed {
                    Text("Remaining: \(max(vm.sequence.count - vm.userInput.count, 0))")
                } else if vm.phase == .success {
                    Text("Sequence: \(vm.sequence.map(String.init).joined())")
                }
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}



// MARK: - View


struct PhaseBadge: View {
    let phase: DigitMemoryGameViewModel.Phase
    var body: some View {
        let (text, color): (String, Color) = {
            switch phase {
            case .idle: return ("Ready", .blue)
            case .playing: return ("Audio…", .orange)
            case .awaitingInput: return ("Input", .accentColor)
            case .failed: return ("Wrong", .red)
            case .success: return ("Correct", .green)
            case .completed: return ("Done", .purple)
            }
        }()
        return Text(text)
            .font(.caption).bold()
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 10).fill(color.opacity(0.15)))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(color.opacity(0.35), lineWidth: 1))
    }
}

#Preview {
    DigitMemoryGameView()
}
