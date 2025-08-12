//
//  ASGShopView.swift
//  S.Ana Star Gaming
//
//

import SwiftUI

struct ASGShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = NEGShopViewModel()
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)
    private let dayCellHeight: CGFloat = NEGDeviceManager.shared.deviceType == .pad ? 350:200
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
                
                
                
                Image(.shopTextASG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 40:20)
                Spacer()
                ZStack {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.shopBgItems, id: \.self) { item in
                            ZStack {
                                Image(item.icon)
                                    .resizable()
                                    .scaledToFit()
                                
                                
                                VStack {
                                    Spacer()
                                    Image(.buyBtnASG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 40:20)
                                        .onTapGesture {
                                            NEGUser.shared.minusUserMoney(for: item.price)
                                        }
                                }.padding(22)
                                    
                            }
                            .frame(height: dayCellHeight)
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width - 150)
                    
                }
                .frame(height: NEGDeviceManager.shared.deviceType == .pad ? 400:270)
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
    ASGShopView()
}
