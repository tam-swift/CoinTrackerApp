//
//  LaunchView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 24.08.2025.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Уже загружаюсь — не паникуйте!".map{String($0)}
    @State private var showLoadingText: Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var counter = 0
    @State private var loops = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launchTheme.background
                .ignoresSafeArea()
            Image("logo")
                .resizable()
                .frame(width: 120, height: 120)
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.launchTheme.accent)
                                .offset(y: counter == index ? -7 : 0)
                        }
                    }
                    //.transition(AnyTransition.scale.animation(.spring))
                    .transition(.asymmetric(insertion: .move(edge: .top).combined(with: .opacity), removal: .move(edge: .bottom).combined(with: .opacity)))
                    
                }
            }
            .animation(.spring(duration: 1), value: showLoadingText)
            .offset(y: 80)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _  in
            withAnimation(.spring()) {
                if counter == loadingText.count - 1 {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
        .fontDesign(.rounded)
}
