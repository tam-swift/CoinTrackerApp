//
//  HomeViewModel.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 04.08.2025.
//

import Foundation
import Combine

@Observable class HomeViewModel {
    
    var statistics: [Statistic] = []
    
    var allCoins : [Coin] = []
    var portfolio :  [Coin] = []
    
    let coinDataService = CoinDataService.instance
    let marketDataService = MarketDataService.instance
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published @ObservationIgnored var searchText = ""
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        coinDataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellables)
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins : [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapGlobalMarketData(data: MarketData?) -> [Statistic] {
            var stats: [Statistic] = []
            
            guard let data = data else {
                return stats
            }
            
            let marketCap = Statistic(title: "Кап. рынка", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = Statistic(title: "Объем за 24ч", value: data.volume)
            let btcDominance = Statistic(title: "Домин. BTC", value: data.btcDominance)
            let portfolio = Statistic(title: "Портфель", value: "$0.00", percentageChange: 0)
            
            stats.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
            return stats
    }
}
