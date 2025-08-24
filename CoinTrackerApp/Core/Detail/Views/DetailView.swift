//
//  DetailView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 23.08.2025.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let detailViewModels: DetailViewModels
    
    private let coin: Coin
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: Coin) {
        self.coin = coin
        detailViewModels = DetailViewModels(coin: coin)
    }
    var body: some View {
        ZStack {
            CoinImageView(coin: coin)
                        .frame(width: 300, height: 300)
                        .scaleEffect(1.8)
                        .opacity(colorScheme == .dark ? 0.2 : 0.15)
                        .blur(radius: colorScheme == .dark ? 10 : 7)
                        .ignoresSafeArea()
                        .offset(y: -50)
            ScrollView {
                VStack {
                    ChartView(coin: coin)
                        .padding(.vertical)
                    VStack(spacing: 20) {
                        
                        overviewTitle
                        Divider()
                            .background(Color.theme.secondary)
                        overviewGrid
                        
                        additionalTitle
                        Divider()
                            .background(Color.theme.secondary)
                        additionalGrid
                    }
                    .padding()
                }
                
            }
            .navigationTitle(coin.name)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Text(coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundStyle(Color.theme.secondary)
                }
            }
        }
        .fontDesign(.rounded)
    }
    
    private var overviewTitle : some View {
        Text("Обзор")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle : some View {
        Text("Детали")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid : some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  content: {
            ForEach(detailViewModels.overviewStats) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var additionalGrid : some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  content: {
            ForEach(detailViewModels.additionalStats) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
}

#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}
