//
//  Crypto.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 21/11/2023.
//

import Foundation
class CryptoList: ObservableObject {
    @Published var cryptos: [Crypto]
    init(cryptos: [Crypto]) {
        self.cryptos = cryptos
    }
}

class Crypto: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String
    @Published var price: Float
    @Published var imageUrl: String
    @Published var isOwned: Bool
    @Published var cryptoInfo: CryptoInfo?
    
    init(name: String, price: Float, imageUrl: String, isOwned: Bool) {
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
        self.isOwned = isOwned
    }
}

struct CryptoInfo: Codable {
    let data: [String: [CryptoData]]
}

struct CryptoData: Codable {
    let urls: Urls
    let logo: String
    let id: Int
    let name: String
    let symbol: String
    let slug: String
    let description: String
    let tags: [String]?
    let category: String
}

struct Urls: Codable {
    let website: [String]
    let technical_doc: [String]
    let reddit: [String]
    let message_board: [String]
    let announcement: [String]
    let chat: [String]
    let explorer: [String]
    let source_code: [String]
}

extension Crypto {
    static let previewData: [Crypto] = [
        Crypto(name: "BTC", price: 36958, imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png", isOwned: true),
        Crypto(name: "ETH", price: 1967, imageUrl: "https://cdn.icon-icons.com/icons2/2699/PNG/512/ethereum_logo_icon_171173.png", isOwned: false),
        Crypto(name: "SOL", price: 62, imageUrl: "https://upload.wikimedia.org/wikipedia/en/b/b9/Solana_logo.png", isOwned: true)
    ]
}
