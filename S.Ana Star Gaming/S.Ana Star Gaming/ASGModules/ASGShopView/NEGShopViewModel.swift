import SwiftUI


final class NEGShopViewModel: ObservableObject {
    // MARK: – Shop catalogues
    @Published var shopBgItems: [NGItem] = [
        NGItem(name: "bg1", image: "bgImage1NEG", icon: "gameBgIcon1NEG", price: 100),
        NGItem(name: "bg2", image: "bgImage2NEG", icon: "gameBgIcon2NEG", price: 100),
        NGItem(name: "bg3", image: "bgImage3NEG", icon: "gameBgIcon3NEG", price: 100),
        NGItem(name: "bg4", image: "bgImage4NEG", icon: "gameBgIcon4NEG", price: 100),
    ]
    
    @Published var shopSkinItems: [NGItem] = [
        NGItem(name: "skin1", image: "skinImage1NEG", icon: "skinIcon1NEG", price: 100),
        NGItem(name: "skin2", image: "skinImage2NEG", icon: "skinIcon2NEG", price: 100),
        NGItem(name: "skin3", image: "skinImage3NEG", icon: "skinIcon3NEG", price: 100),
        NGItem(name: "skin4", image: "skinImage4NEG", icon: "skinIcon4NEG", price: 100),
    ]
    
    // MARK: – Bought
    @Published var boughtBgItems: [NGItem] = [
        NGItem(name: "bg1", image: "bgImage1NEG", icon: "gameBgIcon1NEG", price: 100),
    ] {
        didSet { saveBoughtBg() }
    }

    @Published var boughtSkinItems: [NGItem] = [
        NGItem(name: "skin1", image: "skinImage1NEG", icon: "skinIcon1NEG", price: 100),
    ] {
        didSet { saveBoughtSkins() }
    }
    
    // MARK: – Current selections
    @Published var currentBgItem: NGItem? {
        didSet { saveCurrentBg() }
    }
    @Published var currentSkinItem: NGItem? {
        didSet { saveCurrentSkin() }
    }
    
    // MARK: – UserDefaults keys
    private let bgKey            = "currentBgNEG"
    private let boughtBgKey      = "boughtBgNEG"
    private let skinKey          = "currentSkinNEG1"
    private let boughtSkinKey    = "boughtSkinNEG1"
    
    // MARK: – Init
    init() {
        loadCurrentBg()
        loadBoughtBg()
                
        loadCurrentSkin()
        loadBoughtSkins()
    }
    
    // MARK: – Save / Load Backgrounds
    private func saveCurrentBg() {
        guard let item = currentBgItem,
              let data = try? JSONEncoder().encode(item)
        else { return }
        UserDefaults.standard.set(data, forKey: bgKey)
    }
    private func loadCurrentBg() {
        if let data = UserDefaults.standard.data(forKey: bgKey),
           let item = try? JSONDecoder().decode(NGItem.self, from: data) {
            currentBgItem = item
        } else {
            currentBgItem = shopBgItems.first
        }
    }
    private func saveBoughtBg() {
        guard let data = try? JSONEncoder().encode(boughtBgItems) else { return }
        UserDefaults.standard.set(data, forKey: boughtBgKey)
    }
    private func loadBoughtBg() {
        if let data = UserDefaults.standard.data(forKey: boughtBgKey),
           let items = try? JSONDecoder().decode([NGItem].self, from: data) {
            boughtBgItems = items
        }
    }
    
    // MARK: – Save / Load Skins
    private func saveCurrentSkin() {
        guard let item = currentSkinItem,
              let data = try? JSONEncoder().encode(item)
        else { return }
        UserDefaults.standard.set(data, forKey: skinKey)
    }
    private func loadCurrentSkin() {
        if let data = UserDefaults.standard.data(forKey: skinKey),
           let item = try? JSONDecoder().decode(NGItem.self, from: data) {
            currentSkinItem = item
        } else {
            currentSkinItem = shopSkinItems.first
        }
    }
    private func saveBoughtSkins() {
        guard let data = try? JSONEncoder().encode(boughtSkinItems) else { return }
        UserDefaults.standard.set(data, forKey: boughtSkinKey)
    }
    private func loadBoughtSkins() {
        if let data = UserDefaults.standard.data(forKey: boughtSkinKey),
           let items = try? JSONDecoder().decode([NGItem].self, from: data) {
            boughtSkinItems = items
        }
    }
    
    // MARK: – Example buy action
    func buy(_ item: NGItem, category: NGItemCategory) {
        switch category {
        case .background:
            guard !boughtBgItems.contains(item) else { return }
            boughtBgItems.append(item)
        case .skin:
            guard !boughtSkinItems.contains(item) else { return }
            boughtSkinItems.append(item)
        }
    }
    
    func isPurchased(_ item: NGItem, category: NGItemCategory) -> Bool {
        switch category {
        case .background:
            return boughtBgItems.contains(where: { $0.name == item.name })
        case .skin:
            return boughtSkinItems.contains(where: { $0.name == item.name })
        }
    }

    func selectOrBuy(_ item: NGItem, user: NEGUser, category: NGItemCategory) {
        
        switch category {
        case .background:
            if isPurchased(item, category: .background) {
                currentBgItem = item
            } else {
                guard user.money >= item.price else {
                    return
                }
                user.minusUserMoney(for: item.price)
                buy(item, category: .background)
            }
        case .skin:
            if isPurchased(item, category: .skin) {
                currentSkinItem = item
            } else {
                guard user.money >= item.price else {
                    return
                }
                user.minusUserMoney(for: item.price)
                buy(item, category: .skin)
            }
        }
    }
    
    func isMoneyEnough(item: NGItem, user: NEGUser, category: NGItemCategory) -> Bool {
        user.money >= item.price
    }
    
    func isCurrentItem(item: NGItem, category: NGItemCategory) -> Bool {
        switch category {
        case .background:
            guard let currentItem = currentBgItem, currentItem.name == item.name else {
                return false
            }
            
            return true
            
        case .skin:
            guard let currentItem = currentSkinItem, currentItem.name == item.name else {
                return false
            }
            
            return true
        }
    }
}

enum NGItemCategory: String {
    case background = "background"
    case skin = "skin"
}

struct NGItem: Codable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var icon: String
    var price: Int
    var rate: Double = 1.0
    var level: Int = 1
}
