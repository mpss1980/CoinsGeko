//
//  GlobalCryptoListView.swift
//  CoinsGeko
//
//  Created by Field on 03/01/25.
//
import SwiftUI

struct GlobalCryptoListView: View {
    @ObservedObject private var viewModel: GlobalCryptoListViewModel
    
    init(viewModel: GlobalCryptoListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.loading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Text(viewModel.errorMessage!)
            }
        }.onAppear {
            viewModel.onAppear()
        }.refreshable {
            viewModel.onAppear()
        }
    }
}
