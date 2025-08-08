//
//  HomeStatsView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 08.08.2025.
//

import SwiftUI

struct HomeStatsView: View {
    
    @Environment(HomeViewModel.self) var vm
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environment(DeveloperPreview.instance.homeVM)
}
