//
//  PriceInfoRepository.swift
//  CoinGeko
//
//  Created by Field on 27/12/24.
//
class PriceInfoRepository: PriceInfoRepositoryType {
    private let apiDatasource: CryptoCurrencyApiDatasourceType
    private let errorMapper: CryptoCurrencyFailureMapper

    init(
        apiDatasource: CryptoCurrencyApiDatasourceType,
        errorMapper: CryptoCurrencyFailureMapper
    ) {
        self.apiDatasource = apiDatasource
        self.errorMapper = errorMapper
    }
    
    func getById(id: String) async -> Result<PriceInfo, CryptoCurrencyFailure> {
        let result = await apiDatasource.getPriceInfoForCryptoList(ids: [id])
        
        guard case .success(let successResult) = result else {
            return .failure(errorMapper.map(error: result.failureValue))
        }
        
        guard let priceInfo = successResult.values.first else {
            return .failure(.generic)
        }
        
        return .success(priceInfo.toPriceInfo())
    }
}
