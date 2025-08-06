//
//  CoinImageService.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 06.08.2025.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage?
    
    private var imageSubscription : AnyCancellable?
    private let coin : Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinImage in
                self?.image = returnedCoinImage
                self?.imageSubscription?.cancel()
            })
    }
}
