//
//  CryptoCurrencyApiDatasource.swift
//  CoinGeko
//
//  Created by Field on 25/12/24.
//
protocol CryptoCurrencyApiDatasourceType {
    func getCryptoBasicInfoList() async -> Result<[CryptoCurrencyBasicInfoDto], HttpClientError>
    func getlCryptoSymbolList() async -> Result<[String], HttpClientError>
    func getPriceInfoForCryptoList(ids: [String]) async -> Result<[String : PriceInfoDto], HttpClientError>
    func getPriceHistory(id: String, day: Int) async -> Result<PriceHistoryDto, HttpClientError>
}
