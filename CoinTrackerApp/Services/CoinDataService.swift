//
//  CoinServiceData.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 04.08.2025.
//

import Foundation
import Combine

class CoinDataService {
    
    static let instance = CoinDataService()
    
    @Published var allCoins : [Coin] = []
    
    var coinSubscriprion : AnyCancellable?
    
    private init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=ru&precision=full") else { return }
        
        coinSubscriprion = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard
                    let response = output.response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished :
                    break
                case .failure(let error) :
                    print("Error downloading coins. \(error)")
                }
            } receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }

    }
}
