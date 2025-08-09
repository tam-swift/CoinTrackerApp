//
//  MarketDataService.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 09.08.2025.
//

import Foundation
import Combine

class MarketDataService {
    
    static let instance = MarketDataService()
    
    @Published var marketData : MarketData?
    
    var marketDataSubscription : AnyCancellable?
    
    private init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedData in
                self?.marketData = returnedData.data
                self?.marketDataSubscription?.cancel()
            })

    }
}
