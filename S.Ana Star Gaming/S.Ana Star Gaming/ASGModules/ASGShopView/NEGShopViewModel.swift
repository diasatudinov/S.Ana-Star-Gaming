//
//  NEGShopViewModel.swift
//  S.Ana Star Gaming
//
//


import SwiftUI


final class NEGShopViewModel: ObservableObject {
    // MARK: – Shop catalogues
    @Published var shopBgItems: [NGItem] = [
        NGItem(name: "bg1", icon: "gameBgIcon1ASG", price: 100),
        NGItem(name: "bg2", icon: "gameBgIcon2ASG", price: 100),
        NGItem(name: "bg3", icon: "gameBgIcon3ASG", price: 100),
        NGItem(name: "bg4", icon: "gameBgIcon4ASG", price: 100),
    ]
    
    
}

struct NGItem: Codable, Hashable {
    var id = UUID()
    var name: String
    var icon: String
    var price: Int
}
