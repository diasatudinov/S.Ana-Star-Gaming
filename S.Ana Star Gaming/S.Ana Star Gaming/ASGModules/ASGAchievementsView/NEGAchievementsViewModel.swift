//
//  NEGAchievementsViewModel.swift
//  S.Ana Star Gaming
//
//


import SwiftUI

class NEGAchievementsViewModel: ObservableObject {
    
    @Published var achievements: [NEGAchievement] = [
        NEGAchievement(image: "achieve1ImageASG" ,isAchieved: false),
        NEGAchievement(image: "achieve2ImageASG", isAchieved: false),
        NEGAchievement(image: "achieve3ImageASG", isAchieved: false),
        NEGAchievement(image: "achieve4ImageASG", isAchieved: false),

    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsAchievementsKey = "achievementsKeyASG"
    
    func achieveToggle(_ achive: NEGAchievement) {
        guard let index = achievements.firstIndex(where: { $0.id == achive.id })
        else {
            return
        }
        achievements[index].isAchieved.toggle()
        
    }
    
    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsAchievementsKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsAchievementsKey),
           let loadedItem = try? JSONDecoder().decode([NEGAchievement].self, from: savedData) {
            achievements = loadedItem
        } else {
            print("No saved data found")
        }
    }
}

struct NEGAchievement: Codable, Hashable, Identifiable {
    var id = UUID()
    var image: String
    var isAchieved: Bool
}
