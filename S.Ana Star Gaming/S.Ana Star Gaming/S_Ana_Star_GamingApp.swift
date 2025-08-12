//
//  S_Ana_Star_GamingApp.swift
//  S.Ana Star Gaming
//
//

import SwiftUI

@main
struct S_Ana_Star_GamingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NGRoot()
                .preferredColorScheme(.light)
        }
    }
}
