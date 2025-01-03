//
//  PriceHistoryDto.swift
//  CoinGeko
//
//  Created by Field on 27/12/24.
//
import Foundation

struct PriceHistoryDto: Codable{
    let prices: [[Double]]

    enum CodingKeys: String, CodingKey {
        case prices
    }

    func toPriceHistory() -> PriceHistory {
        let dataPoints: [PriceHistory.DataPoint] = prices.compactMap {
            datapoint in
            guard datapoint.count >= 2, let date = timeStampToDate(datapoint[0]) else { return nil }
            return PriceHistory.DataPoint(date: date, price: datapoint[1])
        }

        return PriceHistory(prices: dataPoints)
    }
    
    private func timeStampToDate(_ timeStamp: Double) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: Date(timeIntervalSince1970: timeStamp))
        
        guard let date = calendar.date(from: components) else { return nil }
        
        return date
        
    }
}
