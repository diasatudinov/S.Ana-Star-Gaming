//
//  NEGDeviceManager.swift
//  S.Ana Star Gaming
//
//


import UIKit

class NEGDeviceManager {
    static let shared = NEGDeviceManager()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}
