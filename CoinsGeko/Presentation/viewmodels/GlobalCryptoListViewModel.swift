//
//  GlobalCryptoListViewModel.swift
//  CoinsGeko
//
//  Created by Field on 03/01/25.
//
import Foundation

class GlobalCryptoListViewModel: ObservableObject {
    private let getGlobalCryptoList: GetCryptoCurrencyListType
    private let errorMapper: CryptoCurrencyPresentableErrorMapper
    @Published var loading: Bool = false
    @Published var errorMessage: String?
    
    init(getGlobalCryptoList: GetCryptoCurrencyListType, errorMapper: CryptoCurrencyPresentableErrorMapper) {
        self.getGlobalCryptoList = getGlobalCryptoList
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        loading = true
        Task {
            let result = await getGlobalCryptoList.excute()
            
            guard case .success(let cryptos) = result else {
                handleError(error: result.failureValue)
                return
            }
            
           //todo: seguir aqui
        }
    }
    
    private func handleError(error: CryptoCurrencyFailure?) {
        Task { @MainActor in
            loading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
}
