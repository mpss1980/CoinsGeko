//
//  CryptoCurrencyCachedDatasource.swift
//  CoinGeko
//
//  Created by Field on 25/12/24.
//
protocol CryptoCurrencyCachedDatasourceType {
    func getCryptoBasicInfoList() async -> [CryptoCurrencyBasicInfo]
    func saveCryptoBasicInfoList(_ list: [CryptoCurrencyBasicInfo]) async
}
