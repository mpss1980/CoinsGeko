//
//  HttpClientError.swift
//  CoinGeko
//
//  Created by Field on 25/12/24.
//
enum HttpClientError: Error {
    case clientError
    case serverError
    case generic
    case parsissionError
    case invalidUrl
    case invalidResponse
    case tooManyRequests
}
