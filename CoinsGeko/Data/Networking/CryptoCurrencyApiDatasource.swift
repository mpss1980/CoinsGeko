//
//  CryptoCurrencyApiDatasource.swift
//  CoinsGeko
//
//  Created by Field on 01/01/25.
//
import Foundation

class CryptoCurrencyApiDatasource: CryptoCurrencyApiDatasourceType {
        
    private let httpClient: HttpClient
    
    private let baseUrl: String = "https://api.coingecko.com/api/v3/"
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func getCryptoBasicInfoList() async -> Result<[CryptoCurrencyBasicInfoDto], HttpClientError> {
        let endpoint = Endpoint(path: "coins/list", queryParameters: [:], method: .get)
        let result = await httpClient.makeRequest(endpoint: endpoint, BaseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue))
        }
        
        guard let cryptoList = try? JSONDecoder().decode([CryptoCurrencyBasicInfoDto].self, from: data) else {
            return .failure(.parsissionError)
        }
        
        return .success(cryptoList)
    }
    
    func getlCryptoSymbolList() async -> Result<[String], HttpClientError> {
        let endpoint = Endpoint(path: "global", queryParameters: [:], method: .get)
        let result = await httpClient.makeRequest(endpoint: endpoint, BaseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue))
        }
        
        guard let symbolList = try? JSONDecoder().decode(CryptoCurrencyGlobalInfoDto.self, from: data) else {
            return .failure(.parsissionError)
        }
         
        return .success(symbolList.data.cryptocurrencies.map { $0.key }.sorted())
    }
    
    func getPriceInfoForCryptoList(ids: [String]) async -> Result<[String : PriceInfoDto], HttpClientError> {
        let queryParameters: [String : Any] = [
            "ids": ids.joined(separator: ","),
            "vs_currencies": "usd",
            "include_market_cap": true,
            "include_24hr_vol": true,
            "include_24hr_change": true
        ]
        
        let endpoint = Endpoint(path: "simple/price", queryParameters: queryParameters, method: .get)
        let result = await httpClient.makeRequest(endpoint: endpoint, BaseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue))
        }
        
        guard let cryptoList = try? JSONDecoder().decode([String : PriceInfoDto].self, from: data) else {
            return .failure(.parsissionError)
        }
        
        return .success(cryptoList)
    }
    
    func getPriceHistory(id: String, day: Int) async -> Result<PriceHistoryDto, HttpClientError> {
        let queryParameters: [String : Any] = [
            "vs_currency": "usd",
            "days": day,
            "interval": "daily"
        ]
        
        let endpoint = Endpoint(path: "coins/ \(id)/market_chart", queryParameters: queryParameters, method: .get)
        let result = await httpClient.makeRequest(endpoint: endpoint, BaseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue))
        }
        
        guard let priceHistoryDto = try? JSONDecoder().decode(PriceHistoryDto.self, from: data) else {
            return .failure(.parsissionError)
        }
        
        return .success(priceHistoryDto)
    }
    
    private func handleError(error: HttpClientError?) -> HttpClientError {
        guard let error else {
            return .generic
        }
        return error
    }
            
}
