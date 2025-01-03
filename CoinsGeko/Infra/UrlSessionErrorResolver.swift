//
//  UrlSessionErrorResolver.swift
//  CoinsGeko
//
//  Created by Field on 03/01/25.
//
class UrlSessionErrorResolver {
    func resolve(statusCode: Int) -> HttpClientError {
        guard statusCode != 429 else {
            return .tooManyRequests
        }
        
        guard statusCode >= 500 else {
            return .clientError
        }
        
        return .serverError
    }
    
    func resolve(error: Error) -> HttpClientError {
        .generic
    }
}
