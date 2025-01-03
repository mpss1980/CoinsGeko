//
//  CryptoCurrencyGlobalInfoDto.swift
//  CoinsGeko
//
//  Created by Field on 01/01/25.
//
struct CryptoCurrencyGlobalInfoDto: Codable {
    let data: CryptoCurrencyGlobalData
    
    struct CryptoCurrencyGlobalData: Codable {
        let cryptocurrencies: [String : Double]
        
        enum CodingKeys: String, CodingKey {
            case cryptocurrencies = "market_cap_percentage"
        }
    }
}
