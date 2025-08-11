//
//  DailyRewardsViewModel.swift
//  S.Ana Star Gaming
//
//


import SwiftUI
import Combine

class DailyRewardsViewModel: ObservableObject {
    @Published private(set) var lastClaimDate: Date?
    @Published private(set) var claimedCount: Int = 0
    @Published private(set) var timeRemaining: TimeInterval = 0
    
    private let totalDays = 7
    private var timerCancellable: AnyCancellable?
    
    var totalDaysCount: Int { totalDays }
    
    init() {
        loadState()
        updateTimeRemaining()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimeRemaining()
            }
    }
    
    deinit {
        timerCancellable?.cancel()
    }
    
    func canClaimNext() -> Bool {
        if claimedCount >= totalDays {
            return false
        }
        if let last = lastClaimDate {
            return Date() >= last.addingTimeInterval(24 * 60 * 60)
        } else {
            return claimedCount == 0
        }
    }
    
    func claimNext() {
        if claimedCount >= totalDays {
            resetCycle()
        }
        guard canClaimNext() else { return }
        NEGUser.shared.updateUserMoney(for: 40)
        claimedCount += 1
        lastClaimDate = Date()
        saveState()
        updateTimeRemaining()
    }
    
    func isDayUnlocked(_ day: Int) -> Bool {
        return day <= claimedCount || (day == claimedCount + 1 && canClaimNext())
    }
    
    func isDayClaimed(_ day: Int) -> Bool {
        return day <= claimedCount
    }
    
    private func resetCycle() {
        claimedCount = 0
        lastClaimDate = nil
        saveState()
    }
    
    private func updateTimeRemaining() {
        guard let last = lastClaimDate else {
            timeRemaining = 0
            return
        }
        let nextDate = last.addingTimeInterval(24 * 60 * 60)
        let now = Date()
        if claimedCount >= totalDays {
            timeRemaining = max(0, nextDate.timeIntervalSince(now))
            if now >= nextDate {
                resetCycle()
                timeRemaining = 0
            }
        } else {
            timeRemaining = max(0, nextDate.timeIntervalSince(now))
        }
    }
    
    func formattedTimeRemaining() -> String {
        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func saveState() {
        let defaults = UserDefaults.standard
        defaults.set(claimedCount, forKey: "claimedCount")
        defaults.set(lastClaimDate, forKey: "lastClaimDate")
    }
    
    private func loadState() {
        let defaults = UserDefaults.standard
        claimedCount = defaults.integer(forKey: "claimedCount")
        lastClaimDate = defaults.object(forKey: "lastClaimDate") as? Date
    }
}
