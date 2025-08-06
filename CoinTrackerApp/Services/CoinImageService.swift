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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName : String
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedimage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedimage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinImage in
                guard
                    let self = self, let downloadingImage = returnedCoinImage else { return }
                self.image = returnedCoinImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadingImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
