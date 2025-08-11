//
//  ASGAchievementsView.swift
//  S.Ana Star Gaming
//
//

import SwiftUI

struct ASGAchievementsView: View {
    @StateObject var user = NEGUser.shared
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = NEGAchievementsViewModel()
    @State private var index = 0
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Image(.backIconASG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 100:60)
                    }
                    
                    Spacer()
                    NEGCoinBg()
                }.padding()
                
                HStack {
                    Image(.achievetsTextASG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 150:20)
                }.padding(.vertical, 40)
                
                VStack {
                    ForEach(viewModel.achievements, id: \.self) { achivement in
                        achievementItem(item: achivement)
                    }
                }
                Spacer()
                
            }
        }.background(
            ZStack {
                Image(.appBgASG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                
            }
        )
    }
    
    @ViewBuilder func achievementItem(item: NEGAchievement) -> some View {
        
        ZStack {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 60)
                .opacity(item.isAchieved ? 1 : 0.5)
                .onTapGesture {
                    viewModel.achieveToggle(item)
                }
        }
    }
}



#Preview {
    ASGAchievementsView()
}
