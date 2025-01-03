//
//  HttpClient.swift
//  CoinsGeko
//
//  Created by Field on 01/01/25.
//
import Foundation

protocol HttpClient {
    func makeRequest(endpoint: Endpoint, BaseUrl: String) async -> Result<Data, HttpClientError>
}

class UrlSessionCryptoHttpClient: HttpClient {
    private let session: URLSession
    private let resquestMaker: UrlSessionRequestMaker
    private let errorResolver: UrlSessionErrorResolver
    
    init(session: URLSession = .shared, resquestMaker: UrlSessionRequestMaker, errorResolver: UrlSessionErrorResolver) {
        self.session = session
        self.resquestMaker = resquestMaker
        self.errorResolver = errorResolver
    }
    
    
    func makeRequest(endpoint: Endpoint, BaseUrl: String) async -> Result<Data, HttpClientError> {
        guard let url = resquestMaker.url(endpoint: endpoint, baseUrl: BaseUrl) else {
            return .failure(.invalidUrl)
        }
        
        do {
            let result = try await session.data(from: url)
            
            guard let response = result.1 as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            guard response.statusCode == 200 else {
                return .failure(errorResolver.resolve(statusCode: response.statusCode))
            }
            
            return .success(result.0)
        } catch {
            return .failure(errorResolver.resolve(error: error))
        }
    }
}
