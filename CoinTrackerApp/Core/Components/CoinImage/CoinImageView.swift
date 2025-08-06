//
//  CoinImageView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 06.08.2025.
//

import SwiftUI


struct CoinImageView: View {
    
    @State var vm : CoinImageViewModel
    init(coin: Coin) {
        _vm = State(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
                    .tint(Color.theme.accent)
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondary)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.instance.coin)
}
