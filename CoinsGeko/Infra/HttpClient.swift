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

