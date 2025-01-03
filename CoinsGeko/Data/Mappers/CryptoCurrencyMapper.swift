//
//  CryptoCurrencyMapper.swift
//  CoinGeko
//
//  Created by Field on 26/12/24.
//
class CryptoCurrencyMapper {
    func getCryptocurrencyBuilderList(symbolList: [String], cryptoList: [CryptoCurrencyBasicInfoDto]) -> [CryptoCurrencyBuilder] {
        var symbolListDic = [String: Bool]()
        symbolList.forEach{ symbol in symbolListDic[symbol] = true }
        
        let filteredCryptoList = cryptoList.filter( { symbolListDic[$0.symbol] ?? false})
        let cryptoBuilderList = filteredCryptoList.map { CryptoCurrencyBuilder(id: $0.id, name: $0.name, symbol: $0.symbol)}
        return cryptoBuilderList
    }
    
    
    func map(cryptoBuilderList: [CryptoCurrencyBuilder], priceInfo: [String : PriceInfoDto]) -> [CryptoCurrency] {
        cryptoBuilderList.forEach { cryptocurrencyBuilder in
                    if let priceInfo = priceInfo[cryptocurrencyBuilder.id] {
                        cryptocurrencyBuilder.price = priceInfo.price
                        cryptocurrencyBuilder.volume24h = priceInfo.volume24h
                        cryptocurrencyBuilder.marketCap = priceInfo.marketCap
                        cryptocurrencyBuilder.price24h = priceInfo.price24h
                    }
                }
        return cryptoBuilderList.compactMap { $0.build() }
    }
}
