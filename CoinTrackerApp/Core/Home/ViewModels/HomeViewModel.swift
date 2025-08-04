//
//  HomeViewModel.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 04.08.2025.
//

import Foundation
import Combine

@Observable class HomeViewModel {
    
    var allCoins : [Coin] = []
    var portfolio :  [Coin] = []
    
    let coinDataService = CoinDataService.instance
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getAllCoinsFromCoinDataService()
    }
    
    func getAllCoinsFromCoinDataService() {
        coinDataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
