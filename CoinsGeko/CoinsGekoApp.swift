//
//  CoinsGekoApp.swift
//  CoinsGeko
//
//  Created by Field on 01/01/25.
//

import SwiftUI

@main
struct CoinsGekoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                globalCryptoList: GlobalCryptoListFactory.create()
            )
        }
    }
}
