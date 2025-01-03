//
//  CryptoCurrencyRepository.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol CryptoCurrencyRepositoryType {
    func getAll() async -> Result<[CryptoCurrency], CryptoCurrencyFailure>
}
