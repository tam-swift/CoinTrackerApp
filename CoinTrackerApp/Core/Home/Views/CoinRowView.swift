//
//  CoinRowView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 02.08.2025.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : Coin
    let showHoldingColumn : Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview {
    CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingColumn: true)
}

extension CoinRowView {
    
    private var leftColumn: some View{
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondary)
                .frame(minWidth: 20)
                .padding(.horizontal, 5)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingValue.asCurrencyWith246Decimals())
                .bold()
            Text(coin.currentHoldings?.description ?? "0.00")
        }
        .foregroundStyle(Color.theme.accent)
    }
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith246Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 3) {
                Image(systemName: coin.priceChangePercentage24H?.getChevron() ?? "")
                    .font(.caption)
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
            }
            .foregroundStyle(
                abs(coin.priceChangePercentage24H ?? 0 ) < 0.01 ?
                Color.theme.secondary :
                    (coin.priceChangePercentage24H ?? 0 > 0 ?
                     Color.theme.green :
                        Color.theme.red)
            )
        }
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
    }
}
