//
//  Crypto.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 21/11/2023.
//

import Foundation
class CryptoList: ObservableObject, Codable {
    @Published var cryptos: [Crypto]

    enum CodingKeys: CodingKey {
        case cryptos
    }

    init(cryptos: [Crypto]) {
        self.cryptos = cryptos
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cryptos = try container.decode([Crypto].self, forKey: .cryptos)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cryptos, forKey: .cryptos)
    }
}

class Crypto: ObservableObject, Identifiable, Codable {
    var id = UUID()
    @Published var name: String
    @Published var price: Float
    @Published var imageUrl: String
    @Published var isOwned: Bool
    // Ensure that CryptoInfo is Codable if you need to persist it
    @Published var cryptoInfo: CryptoInfo?

    enum CodingKeys: CodingKey {
        case id, name, price, imageUrl, isOwned, cryptoInfo
    }

    init(name: String, price: Float, imageUrl: String, isOwned: Bool) {
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
        self.isOwned = isOwned
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Float.self, forKey: .price)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        isOwned = try container.decode(Bool.self, forKey: .isOwned)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(isOwned, forKey: .isOwned)
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
