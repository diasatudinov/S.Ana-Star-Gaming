//
//  DigitMemoryGameViewModel.swift
//  S.Ana Star Gaming
//
//

import SwiftUI
import AVFoundation


//struct DigitMemoryGameView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject private var vm = DigitMemoryGameViewModel()
//
//    var body: some View {
//        ZStack {
//            VStack(spacing: 16) {
//                HStack(alignment: .top) {
//                    Button {
//                        presentationMode.wrappedValue.dismiss()
//                        
//                    } label: {
//                        Image(.backIconASG)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 100:50)
//                    }
//                    Spacer()
//                    
//                    NEGCoinBg()
//                }.padding([.horizontal, .top])
//                
//                Image(.listeningTextASG)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 40:20)
//                
//                ZStack {
//                    Image(.soundTrackImageASG)
//                        .resizable()
//                        .scaledToFit()
//                        
//                    HStack {
//                        Button {
//                            vm.startOrReplayAudio()
//                        } label: {
//                            Image(.playBtnASG)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 140:70)
//                        }.disabled(vm.isSpeaking)
//                        Spacer()
//                    }.padding(.leading, NEGDeviceManager.shared.deviceType == .pad ? 60:35)
//                }.frame(height: NEGDeviceManager.shared.deviceType == .pad ? 200:100)
//                
//                inputStrip
//                keypad
//                Button {
//                    vm.resetInput()
//                } label: {
//                    Image(.codeResetASG)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 110:60)
//                }
//                HStack {
//                    Image(.confirmationBtnASG)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 110:60)
//                    
//                    Image(.backIconASG)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 110:60)
//                    
//                    Image(.resetBtnASG)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 110:55)
//                }
//            }
//            .padding(20)
//            .animation(.easeInOut, value: vm.phase)
//            
//            if vm.phase == .success {
//                
//                ZStack {
//                    Color.black.opacity(0.5).ignoresSafeArea()
//                    
//                    VStack(spacing: 20) {
//                        Image(.victoryTextASG)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 150:80)
//                        
//                        Image(.moneyImageASG)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: UIScreen.main.bounds.width - 236)
//                        
//                        Image(.fiveHundredASG)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 100:55)
//                        
//                        Button {
//                            presentationMode.wrappedValue.dismiss()
//                        } label: {
//                            Image(.nextLevelBtnASG)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 120:65)
//                        }
//                        
//                        Button {
//                            presentationMode.wrappedValue.dismiss()
//                        } label: {
//                            Image(.mainMenuBtnASG)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 100:50)
//                        }
//                    }
//                }
//            }
//            
//        }.background(
//            ZStack {
//                Image(.appBgASG)
//                    .resizable()
//                    .edgesIgnoringSafeArea(.all)
//                    .scaledToFill()
//            }
//        )
//    }
//
//    private var inputStrip: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 8) {
//                ForEach(vm.userInput.indices, id: \.self) { idx in
//                    Text("\(vm.userInput[idx])")
//                        .font(.title2).bold()
//                        .frame(width: 44, height: 44)
//                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
//                }
//                if vm.userInput.isEmpty {
//                    Text("input…")
//                        .foregroundColor(.secondary)
//                }
//            }
//            .padding(.vertical, 6)
//        }
//        .frame(height: 56)
//    }
//
//    private var keypad: some View {
//        VStack(spacing: 10) {
//            ForEach([[1,2,3],[4,5,6],[7,8,9]], id: \.self) { row in
//                HStack(spacing: 10) {
//                    ForEach(row, id: \.self) { n in
//                        digitKey(n)
//                    }
//                }
//            }
//            HStack(spacing: 10) {
//                Spacer(minLength: 0)
//                digitKey(0)
//                Spacer(minLength: 0)
//            }
//        }
//        .opacity(vm.phase == .playing ? 0.4 : 1)
//        .disabled(vm.phase == .playing)
//    }
//
//    private func digitKey(_ n: Int) -> some View {
//        Button {
//            vm.tapDigit(n)
//        } label: {
//            Text("\(n)")
//                .font(.title2).bold()
//                .frame(maxWidth: .infinity)
//                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 140:70)
//                .background(
//                    Image(.numBgASG)
//                        .resizable()
//                        .scaledToFit()
//                )
//        }
//        .buttonStyle(.plain)
//        .disabled(vm.isSpeaking || !(vm.phase == .awaitingInput || vm.phase == .failed))
//    }
//}

#Preview {
    NavigationStack {
        LevelSelectView()
    }
}

struct DigitMemoryGameView: View {
    @Environment(\.presentationMode) var presentationMode

    let startRound: Int
    let onRoundComplete: (Int) -> Void // passes the last passed round

    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = DigitMemoryGameViewModel()
    @State private var configured = false

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
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
                    .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 40:20)
                
                ZStack {
                    Image(.soundTrackImageASG)
                        .resizable()
                        .scaledToFit()
                        
                    HStack {
                        Button {
                            vm.startOrReplayAudio()
                        } label: {
                            Image(.playBtnASG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 120:70)
                        }.disabled(vm.isSpeaking)
                        Spacer()
                    }.padding(.leading, NEGDeviceManager.shared.deviceType == .pad ? 120:35)
                }.frame(height: NEGDeviceManager.shared.deviceType == .pad ? 150:100)
                
                inputStrip
                keypad
                Button {
                    vm.resetInput()
                } label: {
                    Image(.codeResetASG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 90:60)
                }
                HStack {
                    Image(.confirmationBtnASG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 90:60)
                    
                    Image(.backIconASG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 90:60)
                    
                    Image(.resetBtnASG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 90:55)
                }
            }
            .padding(20)
            .animation(.easeInOut, value: vm.phase)
            
            if vm.phase == .success {
                
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Image(.victoryTextASG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 150:80)
                        
                        Image(.moneyImageASG)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 236)
                        
                        Image(.fiveHundredASG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 100:55)
                        
                        Button {
                            onRoundComplete(vm.currentRound)
                            vm.nextRoundIfPossible()
                            
                        } label: {
                            Image(.nextLevelBtnASG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 120:65)
                        }
                        
                        Button {
                            onRoundComplete(vm.currentRound)
                            dismiss()
                        } label: {
                            Image(.mainMenuBtnASG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden()
        .background(
            ZStack {
                Image(.appBgASG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .onAppear {
            if !configured {
                vm.setRound(startRound)
                configured = true
            }
        }
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
                .foregroundStyle(.white)
                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 100:70)
                .background(
                    Image(.numBgASG)
                        .resizable()
                        .scaledToFit()
                )
        }
        .buttonStyle(.plain)
        .disabled(vm.isSpeaking || !(vm.phase == .awaitingInput || vm.phase == .failed))
    }
}
