//
//  PriceHistoryRepository.swift
//  CoinGeko
//
//  Created by Field on 27/12/24.
//
class PriceHistoryRepository: PriceHistoryRepositoryType {
    private let apiDatasource: CryptoCurrencyApiDatasourceType
    private let errorMapper: CryptoCurrencyFailureMapper

    init(
        apiDatasource: CryptoCurrencyApiDatasourceType,
        errorMapper: CryptoCurrencyFailureMapper
    ) {
        self.apiDatasource = apiDatasource
        self.errorMapper = errorMapper
    }

    func getById(id: String, day: Int) async -> Result<
        PriceHistory, CryptoCurrencyFailure
    > {
        let result = await apiDatasource.getPriceHistory(id: id, day: day)

        guard case .success(let priceHistory) = result else {
            return .failure(errorMapper.map(error: result.failureValue))
        }
        
        let mapper = priceHistory.toPriceHistory()
        guard let entity = mapper, mapper != nil else {
            return .failure(.generic)
        }

        return .success(entity)
    }
}
