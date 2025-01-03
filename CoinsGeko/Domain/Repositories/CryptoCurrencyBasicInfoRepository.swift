//
//  CryptoCurrencyBasicInfoRepository.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol CryptoCurrencyBasicInfoRepositoryType {
    func getAll() async -> Result<[CryptoCurrencyBasicInfo], CryptoCurrencyFailure>
    func search(query: String) async -> Result<[CryptoCurrencyBasicInfo], CryptoCurrencyFailure>
    
}
