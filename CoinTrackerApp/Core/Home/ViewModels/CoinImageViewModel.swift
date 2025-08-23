//
//  CoinImageViewModel.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 06.08.2025.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    
    var image: UIImage? = nil
    var isLoading: Bool = false
    
    private let dataService : CoinImageService
    private var coin: Coin
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubsribers()
    }
    private func addSubsribers() {
        isLoading = true
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
