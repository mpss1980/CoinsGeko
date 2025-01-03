//
//  GlobalCryptoListFactory.swift
//  CoinsGeko
//
//  Created by Field on 03/01/25.
//
import Foundation

class GlobalCryptoListFactory {
    static func create() -> GlobalCryptoListView {
        return GlobalCryptoListView(viewModel: createViewModel())
    }
    
    private static func createViewModel() -> GlobalCryptoListViewModel {
        return GlobalCryptoListViewModel(
            getGlobalCryptoList: createGetCryptoListUseCase(),
            errorMapper: CryptoCurrencyPresentableErrorMapper()
        )
    }
    
    private static func createGetCryptoListUseCase() -> GetCryptoCurrencyListType {
        return GetCryptoCurrencyList(
            repository: createRepository()
        )
    }
    
    private static func createRepository() -> CryptoCurrencyRepositoryType {
        return CryptoCurrencyRepository(
            apiDatasource: createApiDataSource(),
            errorMapper: CryptoCurrencyFailureMapper(),
            cryptoCurrencyMapper: CryptoCurrencyMapper()
        )
    }
    
    private static func createApiDataSource() -> CryptoCurrencyApiDatasourceType {
        let httpClient = UrlSessionCryptoHttpClient(
            resquestMaker: UrlSessionRequestMaker(),
            errorResolver: UrlSessionErrorResolver()
        )
        
        return CryptoCurrencyApiDatasource(httpClient: httpClient)
    }
    
}
