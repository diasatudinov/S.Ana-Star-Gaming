// MARK: - Level Select (9 rounds, sequential unlock)
struct LevelSelectView: View {
    @AppStorage("unlockedRound") private var unlockedRound: Int = 1 // persists between launches
    private let totalRounds = 9

    var body: some View {
        VStack(spacing: 20) {
            Text("Choose Round")
                .font(.title).bold()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                ForEach(1...totalRounds, id: \.self) { round in
                    NavigationLink(value: round) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(round <= unlockedRound ? Color.accentColor.opacity(0.15) : Color.gray.opacity(0.15))
                                .frame(height: 72)
                            HStack(spacing: 8) {
                                Image(systemName: round <= unlockedRound ? "checkmark.seal" : "lock.fill")
                                Text("Round \(round)")
                                    .font(.headline)
                            }
                            .foregroundColor(round <= unlockedRound ? .accentColor : .secondary)
                        }
                    }
                    .disabled(round > unlockedRound)
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationDestination(for: Int.self) { round in
            DigitMemoryGameView(startRound: round) { passedRound in
                // unlock next when user passes the chosen round (or any higher within the screen)
                if passedRound >= unlockedRound {
                    unlockedRound = min(passedRound + 1, totalRounds)
                }
            }
        }
        .padding(20)
    }
}