//
//  UrlSessionRequestMaker.swift
//  CoinsGeko
//
//  Created by Field on 03/01/25.
//
import Foundation

class UrlSessionRequestMaker {
    func url(endpoint: Endpoint, baseUrl: String) -> URL? {
        var urlComponents = URLComponents(string: baseUrl + endpoint.path)
        let urlQueryItems = endpoint.queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
        urlComponents?.queryItems = urlQueryItems
        return urlComponents?.url
    }
}
