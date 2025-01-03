//
//  GetPriceInfo.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol GetPriceInfoType {
    func execute(id: String) async -> Result<PriceInfo, CryptoCurrencyFailure>
}

class GetPriceInfo: GetPriceInfoType {
    private let repository: PriceInfoRepositoryType
    
    init(repository: PriceInfoRepositoryType) {
        self.repository = repository
    }
    
    func execute(id: String) async -> Result<PriceInfo, CryptoCurrencyFailure> {
        return await repository.getById(id: id)
    }
}
