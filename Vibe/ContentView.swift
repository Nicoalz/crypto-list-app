//
//  ContentView.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            
            FavoriteView().tabItem {
                Label("Favoris", systemImage: "heart")
            }.tag(1)
            
            Text("Réglages").tabItem{
                Label("Réglages", systemImage: "gearshape")
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
