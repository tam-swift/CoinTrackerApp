//
//  CoinTrackerApp.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 02.08.2025.
//

import SwiftUI

@main
struct CoinTrackerApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}
