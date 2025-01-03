//
//  PriceHistory.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
import Foundation

struct PriceHistory {
    let prices: [DataPoint]
    
    struct DataPoint {
        let date: Date
        let price: Double
    }
}
