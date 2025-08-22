//
//  HomeView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 02.08.2025.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(HomeViewModel.self) var vm
    
    @State private var showPortfolio: Bool = false // animate right
    
    @GestureState private var dragOffset = CGSize.zero
    
    // Properties for set up offsets portfolio view
    @State var startingOffsY : CGFloat = UIScreen.main.bounds.height * 0.81
    @State var currentOffsY: CGFloat = 0
    @State var endOffsY: CGFloat = 0
    
    var body: some View {
        
        // A stub for Bindible (Because using macros @Observable)
        @Bindable var bindableVM = vm
        
        ZStack {
            // background layer
            Color.theme.background.ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $bindableVM.searchText)
                
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
    .environment(DeveloperPreview.instance.homeVM)
}

extension HomeView {
    
    private var homeHeader: some View {
        
        HStack {
            CircleButtonView(iconName: "info")
                .onTapGesture {
                    guard !showPortfolio else {return}
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
            }
        }
        .listStyle(.plain)
        .scrollDismissesKeyboard(.immediately)
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
