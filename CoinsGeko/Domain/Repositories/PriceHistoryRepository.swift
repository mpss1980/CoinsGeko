//
//  PriceHistoryRepository.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol PriceHistoryRepositoryType {
    func getById(id: String, day: Int) async -> Result<PriceHistory, CryptoCurrencyFailure>
}
