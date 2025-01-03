//
//  GetCryptoCurrencyList.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol GetCryptoCurrencyListType {
    func excute() async -> Result<[CryptoCurrency], CryptoCurrencyFailure>
}

class GetCryptoCurrencyList: GetCryptoCurrencyListType {
    private let repository: CryptoCurrencyRepositoryType
    
    init(repository: CryptoCurrencyRepositoryType) {
        self.repository = repository
    }
    
    func excute() async -> Result<[CryptoCurrency], CryptoCurrencyFailure> {
        let result = await repository.getAll()
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            
            return .failure(error)
        }
        
        return .success(cryptoList.sorted { $0.marketCap < $1.marketCap})
    }
}
