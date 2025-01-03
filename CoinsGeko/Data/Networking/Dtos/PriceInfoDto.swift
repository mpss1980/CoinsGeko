//
//  Untitled.swift
//  CoinGeko
//
//  Created by Field on 26/12/24.
//
struct PriceInfoDto: Codable {
    let price: Double
    let marketCap: Double
    let volume24h: Double?
    let price24h: Double?
    
    enum CodingKeys: String, CodingKey {
        case price = "usd"
        case marketCap = "usd_market_cap"
        case volume24h = "usd_24h_vol"
        case price24h = "usd_24h_change"
    }
    
    func toPriceInfo() -> PriceInfo {
        PriceInfo(
            price: price,
            price24h: price24h,
            volume24h: volume24h,
            marketCap: marketCap
        )
    }
    
    func toCryptoCurrency(basicInfo: CryptoCurrencyBasicInfoDto, symbol: String) -> CryptoCurrency {
        CryptoCurrency(
            id: basicInfo.id,
            name: basicInfo.name,
            symbol: symbol,
            price: price,
            price24h: price24h,
            volume24h: volume24h,
            marketCap: marketCap
        )
    }
}
