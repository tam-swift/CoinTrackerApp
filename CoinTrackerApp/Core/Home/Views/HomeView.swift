//
//  HomeView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 02.08.2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm : HomeViewModel
    
    @State private var showPortfolio: Bool = false // animate right
    @State private var showInfo: Bool = false
    
    @GestureState private var dragOffset = CGSize.zero
    
    // Properties for set up offsets portfolio view
    @State private var startingOffsY : CGFloat = UIScreen.main.bounds.height * 0.81
    @State private var currentOffsY: CGFloat = 0
    @State var endOffsY: CGFloat = 0
    
    @State private var isShowingDestination = false
    @State private var selectedCoin: Coin? = nil
    
    var body: some View {
        
        ZStack {
            // background layer
            Color.theme.background.ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnText

                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            VStack(spacing: 10) {
                                Text("На данный момент в вашем портфолио ничего нет. Вы можете добавить монеты в разделе \"Управление активами\", которое находится ниже.")
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                Image(systemName: "chevron.down.dotted.2")
                                    .font(.headline)
                            }
                            .padding(30)
                            .foregroundStyle(Color.theme.accent)
                            
                        } else {
                            porfolioCoinsList
                                .transition(.move(edge: .trailing))
                        }
                    }
                    Spacer(minLength: 70)
                }
                Spacer(minLength: 0)
            }
            PortfolioView(endOf: $endOffsY)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.theme.accent.opacity(0.2), radius: 10)

                .offset(
                    x: showPortfolio ? 0 : UIScreen.main.bounds.width,
                    y: currentOffsY + startingOffsY
                )
                .offset(y: endOffsY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            hideKeyboard()
                            withAnimation(.spring) {
                                currentOffsY = value.translation.height
                            }
                        }
                    
                        .onEnded { value in
                            withAnimation(.spring) {
                                if currentOffsY < -200 {
                                    endOffsY = -startingOffsY * 0.93
                                } else if currentOffsY > 200 && endOffsY != 0  {
                                    endOffsY = 0
                                    vm.searchText = ""
                                }
                                currentOffsY = 0
                            }
                        }
                    
                )
        
        }
        .sheet(isPresented: $showInfo, content: {
            SettingsView()
        })
        .navigationDestination(isPresented: $isShowingDestination) {
            if let coin = selectedCoin {
                DetailView(coin: coin)
            }
        }
        
        .gesture(
            DragGesture(minimumDistance: 20)
                .updating($dragOffset) {
                    value, state, _ in
                    if value.translation.width > 0 {
                        state = value.translation
                    }
                }
                .onEnded{ gesture in
                    if gesture.translation.width > 0 {
                        withAnimation(.spring) {
                            showPortfolio = false
                        }
                    }
                    if gesture.translation.width < 0 {
                        withAnimation(.spring) {
                            showPortfolio = true
                        }
                    }
                }
        )
    }
}


#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden)
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
}

extension HomeView {
    
    private var homeHeader: some View {
        
        HStack {
            CircleButtonView(iconName: "info")
                .onTapGesture {
                    showInfo.toggle()
                }
            Spacer()
            Text(showPortfolio == true ? "Мой портфель" : "Текущие цены")
                .font(.system(.headline, weight: .heavy))
                .foregroundStyle(Color.theme.accent)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
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
                    .onTapGesture {
                        selectedCoin = coin
                        isShowingDestination = true
                    }
            }
            
        }
        .refreshable {
            withAnimation(.linear(duration: 2)) {
                vm.reloadData()
            }
        }
        .listStyle(.plain)
        .scrollDismissesKeyboard(.immediately)
    }

    
    private var porfolioCoinsList : some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        selectedCoin = coin
                        isShowingDestination = true
                    }
            }
        }
        .refreshable {
            withAnimation(.linear(duration: 2)) {
                vm.reloadData()
            }
        }
        .listStyle(.plain)
        .scrollDismissesKeyboard(.immediately)
    }
    
    private var columnText: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Монета")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Активы")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOption == .holdings || vm.sortOption == .holdingsReversed ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Цена")
                    .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondary)
        .padding(.horizontal)
    }
    
    
}

