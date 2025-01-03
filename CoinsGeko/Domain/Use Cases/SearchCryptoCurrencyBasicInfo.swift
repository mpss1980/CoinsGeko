//
//  SearchCryptoCurrencyBasicInfo.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol SearchCryptoCurrencyBasicInfoType {
    func execute(crypto: String) async -> Result<[CryptoCurrencyBasicInfo], CryptoCurrencyFailure>
}

class SearchCryptoCurrencyBasicInfo: SearchCryptoCurrencyBasicInfoType {
    private let repository: CryptoCurrencyBasicInfoRepositoryType
    
    init(repository: CryptoCurrencyBasicInfoRepositoryType) {
        self.repository = repository
    }
    
    func execute(crypto: String) async -> Result<[CryptoCurrencyBasicInfo], CryptoCurrencyFailure> {
        let result = await repository.search(query: crypto)
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        return .success(cryptoList.sorted { $0.name < $1.name})
    }
}
