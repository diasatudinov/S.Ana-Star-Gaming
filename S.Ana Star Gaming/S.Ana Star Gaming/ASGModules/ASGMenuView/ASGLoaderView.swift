//
//  ASGLoaderView.swift
//  S.Ana Star Gaming
//
//

import SwiftUI

struct ASGLoaderView: View {
    @State private var scale: CGFloat = 1.0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            ZStack {
                Image(.loaderBgASG)
                    .resizable()
            }.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                Image(.appLogoASG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                VStack {
                    Image(.loaderTextASG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                    
                    Image(.loaderImageASG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .rotationEffect(.degrees(isAnimating ? 0 : 360))
                        .animation(
                            .linear(duration: 1) // скорость вращения
                                .repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                        .onAppear {
                            isAnimating = true
                        }
                }
                Spacer()
            }
            .padding(.vertical, 50)
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 1 {
                progress += 0.01
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    ASGLoaderView()
}
