//
//  CryptoCurrencyBasicInfoDto.swift
//  CoinGeko
//
//  Created by Field on 25/12/24.
//
struct CryptoCurrencyBasicInfoDto: Codable {
    let id: String
    let name: String
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
    }
    
    func toCryptoCurrencyBasicInfo() -> CryptoCurrencyBasicInfo {
        CryptoCurrencyBasicInfo(id: id, name: name, symbol: symbol)
    }
}
