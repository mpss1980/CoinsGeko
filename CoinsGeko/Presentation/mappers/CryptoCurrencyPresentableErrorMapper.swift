//
//  CryptoCurrencyPresentableErrorMapper.swift
//  CoinsGeko
//
//  Created by Field on 03/01/25.
//
class CryptoCurrencyPresentableErrorMapper {
    func map(error: CryptoCurrencyFailure?) -> String {
        guard error == .tooManyRequests else {
            return "Something went wrong"
        }
        
        return "You have exceeded the limit. Please try again later"
    }
}
