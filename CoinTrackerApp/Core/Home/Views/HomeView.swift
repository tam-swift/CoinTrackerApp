//
//  HomeView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 02.08.2025.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(HomeViewModel.self) var vm
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        
        ZStack {
            // background layer
            Color.theme.background.ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                columnText
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    porfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden)
    }
    .environment(DeveloperPreview.instance.homeVM)
}

extension HomeView {
    
    private var homeHeader: some View {
        
        HStack {
            CircleButtonView(iconName: showPortfolio == true ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio == true ? "Мой портфель" : "Текущие цены")
                .font(.system(.headline, weight: .heavy))
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio == true ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        
    }
    
    private var allCoinsList : some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var porfolioCoinsList : some View {
        List {
            ForEach(vm.portfolio) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnText: some View {
        HStack {
            Text("Монета")
            Spacer()
            if showPortfolio {
                Text("Активы")
            }
            Text("Цена")
                .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondary)
        .padding(.horizontal)
    }
}
