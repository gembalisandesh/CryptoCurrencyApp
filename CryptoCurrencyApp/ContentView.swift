//
//  ContentView.swift
//  CryptoCurrencyApp
//
//  Created by user263604 on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CryptoDataViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error \(errorMessage)")
                        .foregroundColor(.red)
                }
                
                
                List(viewModel.cryptoData) { crypto in
                    VStack(alignment: .leading) {
                        Text(crypto.name)
                            .font(.headline)
                        Text("Symbol: \(crypto.symbol)")
                        Text("Price: \(crypto.price_usd) USD")
                        Text("24h Change: \(crypto.percent_change_24h)%")
                        Text("7d Change: \(crypto.percent_change_7d)%")
                        Text("Market Cap: \(crypto.market_cap_usd) USD")
                    }
                }
                .navigationTitle("Cryptocurrency Data")
            }
        }
    }
}

#Preview {
    ContentView()
}
