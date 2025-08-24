//
//  PortfolioView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 11.08.2025.
//

import SwiftUI

struct PortfolioView: View {

    @EnvironmentObject var vm : HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText = ""
    @FocusState private var focusTF : Bool
    
    @Binding var endOf : CGFloat
    
    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            previewTitle
            SearchBarView(searchText: $vm.searchText)
            if vm.allCoins.isEmpty {
                Text("Монеты не найдены")
                    .padding()
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(Color.theme.accent)
            } else {
                coinLogoList
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
            
            if selectedCoin != nil {
                VStack(spacing: 10) {
                    currentCoinSetUp
                    addButton
                    if let portfCoin = vm.portfolioCoins.first(where: {$0.id == selectedCoin?.id}), portfCoin.currentHoldings != nil  {
                        removeButton
                    }
                }
            }
            Spacer()
        }
        .animation(.spring(), value: vm.allCoins.isEmpty)
        .background(Material.thin)
        .onChange(of: vm.searchText) { _ , value in
            if value == "" {
                withAnimation {
                    selectedCoin = nil
                }
            }
        }
        
    }
    
    
}
#Preview {
    PortfolioView(endOf: .constant(0))
        .environmentObject(DeveloperPreview.instance.homeVM)
        
}

extension PortfolioView {
    private var coinLogoList : some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins.sorted(by: sortedPortfolioCoins)) { coin in
                    VStack {
                        if let portfCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}), let holding = portfCoin.currentHoldings  {
                            Text(holding.description)
                                .font(.caption)
                                .foregroundStyle(Color.theme.secondary)
                        }
                        CoinIconView(coin: coin)
                    }
                        //.opacity(coin == selectedCoin ? 0.5 : 1)
                        .opacity(sortedPortfolioCoins(coin: coin, coin) || coin.id == selectedCoin?.id ? 1  : 0.7)
                        .frame(width: 90, height: 110)
                        .background(Color.theme.secondary.opacity(
                            coin.id == selectedCoin?.id ? 0.3 : 0))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                guard coin.id != selectedCoin?.id else {
                                    selectedCoin = nil
                                    return
                                }
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        
                    VerticalDivider()
                }
                
            }
        }
        .frame(height: 120)
        .scrollDismissesKeyboard(.immediately)
    }
    
    private var currentCoinSetUp: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Цена \(selectedCoin?.symbol.uppercased() ?? "")")
                    .font(.headline)
                    
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith246Decimals() ?? "")
                    .foregroundStyle(Color.theme.accent)
            }
            Divider()
            HStack {
                Text("Общая стоимость")
                    .font(.headline)
                Spacer()
                Text(getCurrentValue())
                    .foregroundStyle(Color.theme.accent)
            }
            Divider()
            HStack {
                Text("Количество")
                    .font(.headline)
                Spacer()
                TextField("14.1", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .foregroundStyle(Color.theme.accent)
                    .focused($focusTF)
            }
            
        }
        .foregroundStyle(Color.theme.secondary)
        .padding(20)
        .padding(.top)
    }
    
    private var addButton: some View {
        Button(action: {
            withAnimation(.easeIn) {
                pressSaveButton()
            }
        }) {
            Text("Добавить")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.theme.background)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .contentShape(RoundedRectangle(cornerRadius: 15))
                .shadow(
                    color: Color.theme.accent.opacity(quantityText.isEmpty ? 0 :0.4),
                    radius: 10)
        }
        .opacity(quantityText.isEmpty ? 0.3 : 1)
        .padding(.horizontal)
        .padding(.bottom)

    }
    private var removeButton: some View {
        Button(action: {
            withAnimation(.easeIn) {
                pressRemoveButton()
            }
        }) {
            Text("Аннулировать")
                .font(.headline)
                .foregroundStyle(Color.theme.red.opacity(0.8))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.theme.background)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .contentShape(RoundedRectangle(cornerRadius: 15))
                .shadow(
                    color: Color.theme.red.opacity(quantityText.isEmpty ? 0 :0.2),
                    radius: 10)
        }
        .opacity(quantityText.isEmpty ? 0.3 : 1)
        .padding(.horizontal)

    }
    private var previewTitle: some View {
        VStack {
            Image(systemName: "chevron.compact.up")
                .font(.headline)
                .rotationEffect(Angle(degrees: endOf != 0 ? 180 : 0))
                .padding(.top, 5)
            Text("Управление активами")
                .font(.largeTitle)
                .bold()
                .padding(.top)
        }
        .foregroundStyle(Color.theme.accent)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }
    
    private func sortedPortfolioCoins(coin: Coin, _ _: Coin) -> Bool {
        if vm.portfolioCoins.first(where: {$0.id == coin.id}) != nil {
            return true
        } else {
            return false
        }
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    private func getCurrentValue() -> String {
        if let quant = Double(quantityText.replacingOccurrences(of: ",", with: ".")) {
            let currentValue = (quant * (selectedCoin?.currentPrice ?? 0)).asCurrencyWith246Decimals()
            return String(currentValue)
        }
        return "$0.00"
    }
    
    private func pressSaveButton() {
        guard let coin = selectedCoin else { return }
        guard let holding = Double(quantityText.replacingOccurrences(of: ",", with: ".")), holding > 0.000001 || holding == 0 else {
            focusTF.toggle()
            return
        }
        vm.updatePortfolio(coin: coin, amount: holding)
        hideKeyboard()
        endOf = 0
        quantityText = ""
        vm.searchText = ""
        selectedCoin = nil
    }
    private func pressRemoveButton() {
        guard let coin = selectedCoin else { return }
        guard let portfCoin = vm.portfolioCoins.first(where: {$0.id == selectedCoin?.id}), let holding = portfCoin.currentHoldings, holding != 0 else { return }
        vm.updatePortfolio(coin: coin, amount: 0)
        hideKeyboard()
        endOf = 0
        quantityText = ""
        vm.searchText = ""
        selectedCoin = nil
    }
}
