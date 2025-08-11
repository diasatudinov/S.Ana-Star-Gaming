//
//  NEGCoinBg.swift
//  S.Ana Star Gaming
//
//


import SwiftUI

struct NEGCoinBg: View {
    @StateObject var user = NEGUser.shared
    var height: CGFloat = NEGDeviceManager.shared.deviceType == .pad ? 70:35
    var body: some View {
        HStack(spacing: 5) {
            Image(.coinsIconASG)
                .resizable()
                .scaledToFit()
            
            Text("+\(user.money)")
                .font(.system(size: NEGDeviceManager.shared.deviceType == .pad ? 30:20, weight: .semibold))
                .foregroundStyle(.white)
                .textCase(.uppercase)
            
            
            
        }.frame(height: height)
        
    }
}

#Preview {
    NEGCoinBg()
}
