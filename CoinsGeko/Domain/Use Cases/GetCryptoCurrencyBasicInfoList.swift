//
//  GetCryptoCurrencyBasicInfoList.swift
//  CoinGeko
//
//  Created by Field on 24/12/24.
//
protocol GetCryptoCurrencyBasicInfoListType {
    func excute() async -> Result<[CryptoCurrencyBasicInfo], CryptoCurrencyFailure>
}

class GetCryptoCurrencyBasicInfoList: GetCryptoCurrencyBasicInfoListType {
    private let repository: CryptoCurrencyBasicInfoRepositoryType
    
    init(repository: CryptoCurrencyBasicInfoRepositoryType) {
        self.repository = repository
    }
    
    func excute() async -> Result<[CryptoCurrencyBasicInfo], CryptoCurrencyFailure> {
        let result = await repository.getAll()
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            
            return .failure(error)
        }
        
        return .success(cryptoList.sorted { $0.name < $1.name})
    }
}
