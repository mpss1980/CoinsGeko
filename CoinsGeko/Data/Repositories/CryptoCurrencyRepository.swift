//
//  CryptoCurrencyRepository.swift
//  CoinGeko
//
//  Created by Field on 26/12/24.
//
class CryptoCurrencyRepository: CryptoCurrencyRepositoryType {
    private let apiDatasource: CryptoCurrencyApiDatasourceType
    private let errorMapper: CryptoCurrencyFailureMapper
    private let cryptoCurrencyMapper: CryptoCurrencyMapper

    init(
        apiDatasource: CryptoCurrencyApiDatasourceType,
        errorMapper: CryptoCurrencyFailureMapper,
        cryptoCurrencyMapper: CryptoCurrencyMapper
    ) {
        self.apiDatasource = apiDatasource
        self.errorMapper = errorMapper
        self.cryptoCurrencyMapper = cryptoCurrencyMapper
    }

    func getAll() async -> Result<[CryptoCurrency], CryptoCurrencyFailure> {
        let symbolListResult = await apiDatasource.getlCryptoSymbolList()
        let basicCryptoListResult = await apiDatasource.getCryptoBasicInfoList()

        guard case .success(let symbolList) = symbolListResult else {
            return .failure(
                errorMapper.map(error: symbolListResult.failureValue))
        }

        guard case .success(let basicCryptoList) = basicCryptoListResult else {
            return .failure(
                errorMapper.map(error: basicCryptoListResult.failureValue))
        }

        let cryptoCurrencyBuilderList =
            cryptoCurrencyMapper.getCryptocurrencyBuilderList(
                symbolList: symbolList,
                cryptoList: basicCryptoList.filter { !$0.id.contains("-") })

        let priceListResult = await apiDatasource.getPriceInfoForCryptoList(
            ids: cryptoCurrencyBuilderList.map { $0.id })
        guard case .success(let priceList) = priceListResult else {
            return .failure(
                errorMapper.map(error: priceListResult.failureValue))
        }

        let cryptoCurrencyList = cryptoCurrencyMapper.map(
            cryptoBuilderList: cryptoCurrencyBuilderList, priceInfo: priceList)

        return .success(cryptoCurrencyList)

    }
}
