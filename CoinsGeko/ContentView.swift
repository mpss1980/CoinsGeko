//
//  ContentView.swift
//  CoinsGeko
//
//  Created by Field on 01/01/25.
//

import SwiftUI

struct ContentView: View {
    let globalCryptoList: GlobalCryptoListView
    
    var body: some View {
        TabView {
            globalCryptoList.tabItem {
                Label("Global", systemImage: "list.dash")
            }
        }
    }
}
