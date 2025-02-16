//
//  CryptoCurrencyBuilder.swift
//  CoinGeko
//
//  Created by Field on 26/12/24.
//
class CryptoCurrencyBuilder {
    let id: String
    let name: String
    let symbol: String
    var price: Double?
    var price24h: Double?
    var volume24h: Double?
    var marketCap: Double?
    
    init(id: String, name: String, symbol: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
    }
    
    func build() -> CryptoCurrency? {
        guard let price = price, let marketCap = marketCap else { return nil }
        return CryptoCurrency(id: id, name: name, symbol: symbol, price: price, price24h: price24h, volume24h: volume24h, marketCap: marketCap)
    }
    
}
