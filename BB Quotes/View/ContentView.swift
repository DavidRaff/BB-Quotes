//
//  ContentView.swift
//  BB Quotes
//
//  Created by David Laczkovits on 09.10.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show: Constants.bbName)
                .tabItem { Label(Constants.bbName, systemImage: "tortoise") }
            
            QuoteView(show: Constants.bcsName)
                .tabItem { Label(Constants.bcsName, systemImage: "briefcase") }
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
