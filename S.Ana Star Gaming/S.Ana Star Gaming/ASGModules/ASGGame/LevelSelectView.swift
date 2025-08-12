//
//  LevelSelectView.swift
//  S.Ana Star Gaming
//
//

import SwiftUI

struct LevelSelectView: View {
    @AppStorage("unlockedRound4") private var unlockedRound: Int = 1
    private let totalRounds = 9
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                HStack(alignment: .top) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Image(.backIconASG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 100:50)
                    }
                    Spacer()
                    
                    NEGCoinBg()
                }.padding([.horizontal, .top])
                
                Image(.listeningTextASG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 50:25)
                
                Spacer()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                    ForEach(1...totalRounds, id: \.self) { round in
                        NavigationLink(value: round) {
                            ZStack {
                                Image(round <= unlockedRound ? .levelOpenASG : .levelCloseASG)
                                    .resizable()
                                    .scaledToFit()
                                VStack(spacing: 8) {
                                    Spacer()
                                    Text("Level \(round)")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .padding(12)
                                }
                                .foregroundColor(round <= unlockedRound ? .accentColor : .secondary)
                            }.frame(height: NEGDeviceManager.shared.deviceType == .pad ? 200:110)

                        }
                        .disabled(round > unlockedRound)
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
            }
            .navigationDestination(for: Int.self) { round in
                DigitMemoryGameView(startRound: round) { passedRound in
                    if passedRound >= unlockedRound {
                        unlockedRound = min(passedRound + 1, totalRounds)
                        NEGUser.shared.updateUserMoney(for: 500)
                    }
                }
            }
            .padding(20)
        }.background(
            ZStack {
                Image(.appBgASG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
}

#Preview {
    NavigationStack {
        LevelSelectView()
    }
}
