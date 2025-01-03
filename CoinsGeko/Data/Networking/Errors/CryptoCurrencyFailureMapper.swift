//
//  CryptoCurrency.swift
//  CoinGeko
//
//  Created by Field on 25/12/24.
//
class CryptoCurrencyFailureMapper {
    func map(error: HttpClientError?) -> CryptoCurrencyFailure {
        guard error == .tooManyRequests else {
            return .generic
        }
        
        return .tooManyRequests
    }
}
