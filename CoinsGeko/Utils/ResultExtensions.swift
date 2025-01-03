//
//  ResultExtensions.swift
//  CoinGeko
//
//  Created by Field on 25/12/24.
//
extension Result {
    var failureValue: Failure? {
        switch self {
        case .failure(let failure):
            return failure
        default:
            return nil
        }
    }
}
