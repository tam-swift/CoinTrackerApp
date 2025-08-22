//
//  VerticalDivider.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 12.08.2025.
//

import SwiftUI

struct VerticalDivider: View {
    
    let color: Color = Color.theme.secondary
    let width: CGFloat = 1
    let height: CGFloat = 30

    var body: some View {
        color.frame(width: width, height: height)
    }
}

#Preview {
    VerticalDivider()
}
