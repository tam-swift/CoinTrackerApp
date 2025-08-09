//
//  StatisticView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 08.08.2025.
//

import SwiftUI

struct StatisticView: View {

    
    let stat: Statistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondary)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 3) {
                Image(systemName: stat.percentageChange?.getChevron() ?? "")
                    .font(.caption2)
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(
                abs(stat.percentageChange ?? 0) < 0.01 ?
                Color.theme.secondary :
                    (stat.percentageChange ?? 0 > 0 ?
                     Color.theme.green :
                        Color.theme.red)
            )
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

#Preview {
    StatisticView(stat: DeveloperPreview.instance.stat)
}
