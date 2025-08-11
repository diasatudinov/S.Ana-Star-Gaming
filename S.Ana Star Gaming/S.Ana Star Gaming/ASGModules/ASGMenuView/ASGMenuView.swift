//
//  ASGMenuView.swift
//  S.Ana Star Gaming
//
//

import SwiftUI

struct ASGMenuView: View {
    @State private var showGame = false
    @State private var showShop = false
    @State private var showAchievement = false
    @State private var showMiniGames = false
    @State private var showSettings = false
    @State private var showCalendar = false
    @State private var showDailyTask = false
    
//    @StateObject var achievementVM = NEGAchievementsViewModel()
//    @StateObject var settingsVM = NGSettingsViewModel()
//    @StateObject var shopVM = NEGShopViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 20) {
                    
                    Spacer()
                    
                    NEGCoinBg()
                    
                    
                    
                }.padding(15)
                
                Spacer()
                Image(.appLogoASG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                Spacer()
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        Button {
                            showGame = true
                        } label: {
                            Image(.playIconASG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 120:60)
                        }
                    }
                    
                    Button {
                        showShop = true
                    } label: {
                        Image(.shopIconASG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 120:60)
                    }
                    
                    Button {
                        showAchievement = true
                    } label: {
                        Image(.achievementsIconASG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 120:60)
                    }
                    
                    Button {
                        showSettings = true
                    } label: {
                        Image(.settingsIconASG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 120:60)
                    }
                }
                Spacer()
                
                HStack {
                    Button {
                        showDailyTask = true
                    } label: {
                        Image(.dailyBonusIconASG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 140:80)
                    }
                    Spacer()
                }
            }.padding()
        }
        .background(
            ZStack {
                Image(.appBgASG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $showGame) {
//            NGRoundSelectionView()
        }
        .fullScreenCover(isPresented: $showAchievement) {
//            NEGAchievementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showShop) {
//            NEGShopView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
//            NEGSettingsView(settingsVM: settingsVM)
        }
        .fullScreenCover(isPresented: $showDailyTask) {
//            DailyRewardsView()
        }
    }
    
}

#Preview {
    ASGMenuView()
}
