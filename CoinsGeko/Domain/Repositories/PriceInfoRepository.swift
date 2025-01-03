//
//  PriceInfoRepository.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol PriceInfoRepositoryType {
    func getById(id: String) async -> Result<PriceInfo, CryptoCurrencyFailure>
}
