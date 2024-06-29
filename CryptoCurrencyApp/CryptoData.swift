//
//  CryptoData.swift
//  CryptoCurrencyApp
//
//  Created by user263604 on 6/26/24.
//

import Foundation
import Foundation

struct CryptoResponse: Decodable {
    let data: [CryptoData]
}

struct CryptoData: Decodable, Identifiable {
    var id: String { return nameid }
    let symbol: String
    let name: String
    let nameid: String
    let rank: Int
    let price_usd: String
    let percent_change_24h: String
    let percent_change_1h: String
    let percent_change_7d: String
    let price_btc: String
    let market_cap_usd: String
    let volume24: Double
    let volume24a: Double
    let csupply: String
    let tsupply: String
    let msupply: String?
}
