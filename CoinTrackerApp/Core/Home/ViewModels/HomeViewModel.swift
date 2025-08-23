//
//  HomeViewModel.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 04.08.2025.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    var statistics: [Statistic] = []
    
    // Published wrapper for using subscribers
    @Published var allCoins : [Coin] = []
    @Published var portfolioCoins :  [Coin] = []
    @Published var searchText = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()

    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellables)
        
        
        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        coinDataService.getCoins()
        marketDataService.getMarketData()
    }
    
    private func filterAndSortCoins(text: String, coins : [Coin], sort: SortOption) -> [Coin] {
        var filteredCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &filteredCoins)
        return filteredCoins
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
    
    private func sortCoins(sort: SortOption, coins: inout [Coin]) {
        switch sort {
        case .price:
            coins.sort {$0.currentPrice > $1.currentPrice}
        case .priceReversed:
            coins.sort {$0.currentPrice < $1.currentPrice}
        case .rank, .holdings:
            coins.sort {$0.rank < $1.rank}
        case .rankReversed, .holdingsReversed:
            coins.sort {$0.rank > $1.rank}
        }
    }
    
    private func sortPortfolioIfNeeded(coins: [Coin]) -> [Coin] {
        // will only sort by holdings or reversedGoldings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted {$0.currentHoldingValue > $1.currentHoldingValue}
        case .holdingsReversed:
            return coins.sorted {$0.currentHoldingValue < $1.currentHoldingValue}
        default: return coins
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin]{
        allCoins.compactMap { coin -> Coin? in
            guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                return nil
            }
            
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(data: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = data else {
            return stats
        }
        
        let marketCap = Statistic(title: "Кап. рынка", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "Объем за 24ч", value: data.volume)
        let btcDominance = Statistic(title: "Домин. BTC", value: data.btcDominance)

        let portfolioValue =
            portfolioCoins
                .map { $0.currentHoldingValue }
                .reduce(0.0, +)
        
        // 110$ 2% | 1$ 110%
        let previousValue =
        portfolioCoins
            // 110 / (1 + 0.02) | 1 / (1 + 1.1) -> 107.84 | 0.47 -> 107.84 + 0.47 = 108.31
            .map { coin -> Double in
                let currentValue = coin.currentHoldingValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                return currentValue / (1 + percentChange)
            }
            .reduce(0.0, +)
        
        // (110 + 1 - 108.31) / 108.31 * 100  = 2.48
        let portfolioPercentageChange = (portfolioValue - previousValue) / previousValue * 100
        
        let portfolio = Statistic(title: "Портфель",
                                  value: portfolioValue.asCurrencyWith246Decimals(),
                                  percentageChange: portfolioPercentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
