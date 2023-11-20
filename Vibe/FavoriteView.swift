//
//  FavoriteView.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 20/11/2023.
//

import SwiftUI

struct Crypto: Identifiable {
    var id = UUID()
    var name: String
    var price: Float
    var imageUrl: String
    var isOwned: Bool
}

struct FavoriteView: View {
    @State private var cryptoList: [Crypto] = []
    @State private var showingForm = false
    @State private var selectedCrypto: Crypto?
    
    init(cryptoList: [Crypto] = []) {
        _cryptoList = State(initialValue: cryptoList)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cryptoList) { crypto in
                    CryptoRowView(crypto: crypto)
                        .swipeActions(edge: .leading) {
                            Button {
                                self.selectedCrypto = crypto
                                self.showingForm = true
                            } label: {
                                Label("Modifier", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                }
                .onDelete(perform: deleteCrypto)
            }
            .navigationTitle("Cryptos Favorites")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.selectedCrypto = nil
                        self.showingForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingForm) {
                AddCryptoForm(onSave: { crypto in
                    if let selectedCrypto = selectedCrypto, let index = cryptoList.firstIndex(where: { $0.id == selectedCrypto.id }) {
                        cryptoList[index] = crypto
                    } else {
                        cryptoList.append(crypto)
                    }
                }, crypto: selectedCrypto)
            }
        }
    }
    
    private func deleteCrypto(at offsets: IndexSet) {
        cryptoList.remove(atOffsets: offsets)
    }
}


extension Crypto {
    static let previewData: [Crypto] = [
        Crypto(name: "Bitcoin", price: 36958, imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png", isOwned: true),
        Crypto(name: "Ethereum", price: 1967, imageUrl: "https://cdn.icon-icons.com/icons2/2699/PNG/512/ethereum_logo_icon_171173.png", isOwned: false),
        Crypto(name: "Solana", price: 62, imageUrl: "https://upload.wikimedia.org/wikipedia/en/b/b9/Solana_logo.png", isOwned: true)
    ]
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(cryptoList: Crypto.previewData)
    }
}
