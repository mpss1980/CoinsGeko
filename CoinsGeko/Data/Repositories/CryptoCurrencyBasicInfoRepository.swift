//
//  CryptoCurrencyBasicInfoRepository.swift
//  CoinGeko
//
//  Created by Field on 25/12/24.
//
class CryptoCurrencyBasicInfoRepository: CryptoCurrencyBasicInfoRepositoryType {
    private let cacheDatasource: CryptoCurrencyCachedDatasourceType
    private let apiDatasource: CryptoCurrencyApiDatasourceType
    private let errorMapper: CryptoCurrencyFailureMapper
    
    init(cacheDatasource: CryptoCurrencyCachedDatasourceType, apiDatasource: CryptoCurrencyApiDatasourceType, errorMapper: CryptoCurrencyFailureMapper) {
        self.cacheDatasource = cacheDatasource
        self.apiDatasource = apiDatasource
        self.errorMapper = errorMapper
    }

    func getAll() async -> Result<
        [CryptoCurrencyBasicInfo], CryptoCurrencyFailure
    > {
        let cachedList = await cacheDatasource.getCryptoBasicInfoList()

        if !cachedList.isEmpty {
            return .success(cachedList)
        }

        let apiResult = await apiDatasource.getCryptoBasicInfoList()

        guard case .success(let dtoList) = apiResult else {
            return .failure(errorMapper.map(error: apiResult.failureValue))
        }

        let cryptoList = dtoList.map { $0.toCryptoCurrencyBasicInfo() }
        await cacheDatasource.saveCryptoBasicInfoList(cryptoList)

        return .success(cryptoList)
    }

    func search(query: String) async -> Result<
        [CryptoCurrencyBasicInfo], CryptoCurrencyFailure
    > {
        let result = await getAll()
        
        guard case .success(let cryptoList) = result else {
            return result
        }
        
        guard query != "" else {
            return result
        }
        
        let filteredCryptoList = cryptoList.filter { $0.name.lowercased().contains(query.lowercased()) || $0.symbol.lowercased().contains(query.lowercased())}
        
        return .success(filteredCryptoList)
    }
}
