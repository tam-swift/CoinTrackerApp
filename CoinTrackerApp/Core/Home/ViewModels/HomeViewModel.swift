//
//  HomeViewModel.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 04.08.2025.
//

import Foundation

@Observable class HomeViewModel {
    
    var allCoins : [Coin] = []
    var portfolio :  [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolio.append(DeveloperPreview.instance.coin)
        }
    }

}
