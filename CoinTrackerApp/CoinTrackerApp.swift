//
//  CoinTrackerApp.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 02.08.2025.
//

import SwiftUI

@main
struct CoinTrackerApp: App {
    
    @State var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
            .environment(vm)
        }
    }
}
