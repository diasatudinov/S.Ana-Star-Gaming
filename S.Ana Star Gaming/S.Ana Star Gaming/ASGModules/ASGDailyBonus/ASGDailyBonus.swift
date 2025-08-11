//
//  ASGDailyBonus.swift
//  S.Ana Star Gaming
//
//

import SwiftUI

struct ASGDailyBonus: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = DailyRewardsViewModel()

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    private let dayCellHeight: CGFloat = NEGDeviceManager.shared.deviceType == .pad ? 160:90
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                
                
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
                
                
                
                Spacer()
                Image(.dailyBonusTextASG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 40:20)
                Spacer()
                ZStack {
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(1...viewModel.totalDaysCount, id: \.self) { day in
                            if day < 7 {
                                ZStack {
                                    if viewModel.isDayUnlocked(day) {
                                        Image(.daysOnASG)
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(viewModel.isDayClaimed(day) ? 1: viewModel.isDayUnlocked(day) ? 0.7:0.3)
                                    } else {
                                        Image(viewModel.isDayClaimed(day) ?.daysOnASG: .daysOffASG)
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(viewModel.isDayClaimed(day) ? 1: viewModel.isDayUnlocked(day) ? 0.7:0.3)
                                    }
                                    
                                    VStack {
                                        Spacer()
                                        Text("Day \(day)")
                                            .font(.system(size: 15, weight: .bold))
                                            .foregroundStyle(.white)
                                        
                                    }.padding(5)
                                }
                                .frame(height: dayCellHeight)
                                .onTapGesture {
                                    viewModel.claimNext()
                                }
                            }
                        }

                    }.frame(width: UIScreen.main.bounds.width - 0)
                    
                }
                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 400:270)
                ZStack {
                    if viewModel.isDayUnlocked(7) {
                        Image(.day7OnASG)
                            .resizable()
                            .scaledToFit()
                            .opacity(viewModel.isDayClaimed(7) ? 1: viewModel.isDayUnlocked(7) ? 0.7:0.3)
                    } else {
                        Image(viewModel.isDayClaimed(7) ?.day7OnASG: .day7OffASG)
                            .resizable()
                            .scaledToFit()
                            .opacity(viewModel.isDayClaimed(7) ? 1: viewModel.isDayUnlocked(7) ? 0.7:0.3)
                    }
                    
                    VStack {
                        Spacer()
                        Text("Day \(7)")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                        
                    }.padding(5)
                }
                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 160: 100)
                .onTapGesture {
                    viewModel.claimNext()
                }
                Spacer()
            }
            .padding()
            
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
    ASGDailyBonus()
}
