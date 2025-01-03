//
//  GetPriceHistory.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol GetPriceHistoryType {
    func execute(id: String, day: Int) async -> Result<PriceHistory, CryptoCurrencyFailure>
}

class GetPriceHistory: GetPriceHistoryType {
    private let repository: PriceHistoryRepositoryType
    
    init(repository: PriceHistoryRepositoryType) {
        self.repository = repository
    }
    
    func execute(id: String, day: Int) async -> Result<PriceHistory, CryptoCurrencyFailure> {
        return await repository.getById(id: id, day: day)
    }
}
