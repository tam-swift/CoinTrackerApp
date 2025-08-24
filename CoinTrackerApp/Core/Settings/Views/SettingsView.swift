//
//  SettingsView.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 24.08.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss

    let swiftfulThinking = URL(string: "https://www.youtube.com/@SwiftfulThinking")!
    let gitHubURL = URL(string: "https://github.com/tam-swift")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    
    var body: some View {
        NavigationStack {
            List {
                developerSection
                nickSwiftSection
                coinGeckoSection
            }
            .font(.headline)
            .tint(.blue)
            .navigationTitle("Info ")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            dismiss()
                        }
                    }
                    .font(.headline)
                    .foregroundStyle(Color.theme.accent)
                    
                }
                
            }
            
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var developerSection: some View {
        Section("tamerlan swift") {
            VStack(alignment: .leading) {
                HStack(spacing: 30) {
                    Image("my")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.vertical, 5)
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                Text("Приложение разработано Тамерланом Губайдуллиным как пет-проект для резюме. Оно использует SwiftUI и написано на Swift. В проекте используется многопточность, publisher/subsribers и сохранение данных 😉")
                    .font(.headline)
                  //  .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            Link("Посетить мой GitHub 🥰", destination: gitHubURL)
        }
    }
    
    private var nickSwiftSection: some View {
        Section("Swiftful Thinking") {
            VStack(alignment: .leading) {
                Image("nick")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Capsule())
                    .padding(.vertical, 5)
                Text("Это приложение сделано на основе курса от @SwiftfulThinking (Ютуб).")
                    .font(.headline)
                  //  .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            Link("Посетить канал Swiftful Thinking ❤️", destination: gitHubURL)
        }
    }
    
    private var coinGeckoSection: some View {
        Section("CoinGecko") {
            VStack(alignment: .leading) {
                Image("coinGecko")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Text("Вся информация о монетах поступает из бесплатного API CoinGecko.")
                    .font(.headline)
                  //  .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            Link("Открыть CoinGecko 🦎", destination: coinGeckoURL)
        }
    }
    
    
}

