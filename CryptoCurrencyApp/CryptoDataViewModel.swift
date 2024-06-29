//
//  CryptoDataViewModel.swift
//  CryptoCurrencyApp
//
//  Created by user263604 on 6/26/24.
//

import Foundation
import Combine

class CryptoDataViewModel : ObservableObject {
    
    @Published var cryptoData : [CryptoData] = []
    @Published var errorMessage :  String?
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        fetchData()
        
    }
    func fetchData() {
        guard let url = URL(string: "https://api.coinlore.net/api/tickers/?start=100&limit=100") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
                   .map { $0.data }
                   .mapError {_ in CryptoErrror.requestFailed}
                   .decode(type: CryptoResponse.self, decoder: JSONDecoder())
                   .map { $0.data }
                   .mapError {_ in CryptoErrror.decodeFailed}
                   //.map { $0.filter { $0.symbol == "KLAY" } }
                   .receive(on: DispatchQueue.main)
                   .sink(receiveCompletion: { completion in
                       switch completion {
                       case .finished:
                           break
                       case .failure(let error):
                           self.errorMessage = error.localizedDescription
                       }
                   }, receiveValue: { [weak self] data in
                       self?.cryptoData = data
                   })
                   .store(in: &cancellabels)
    }
    enum CryptoErrror: Error, LocalizedError {
        case invalidUrl
        case requestFailed
        case decodeFailed
        var errorDescription: String? {
            switch self {
            case .invalidUrl :
                return "invaild url"
            case .requestFailed:
                return "request failed"
            case .decodeFailed:
                return "decode failed"
            }
        }
    }
    
}
