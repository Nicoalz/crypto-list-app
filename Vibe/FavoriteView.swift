//
//  FavoriteView.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 20/11/2023.
//

import SwiftUI



struct FavoriteView: View {
    @StateObject private var cryptoList: CryptoList
    @State private var showingForm = false
    
    // Initialisez avec un CryptoList vide pour une utilisation normale
    init(cryptoList: CryptoList = CryptoList(cryptos: [])) {
        _cryptoList = StateObject(wrappedValue: cryptoList)
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(cryptoList.cryptos) { crypto in
                    NavigationLink(destination: CryptoDetailsView(crypto: crypto)) {
                        CryptoRowView(crypto: crypto)
                    }
                }
                .onDelete(perform: deleteCrypto) 
            }
            .navigationTitle("Favoris")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingForm) {
                AddCryptoForm(cryptoList:cryptoList,showingForm:$showingForm)
            }
        }
    }
    
    private func deleteCrypto(at offsets: IndexSet) {
        cryptoList.cryptos.remove(atOffsets: offsets)
    }
    
}




struct FavoriteView_Previews: PreviewProvider { 
    static var previews: some View {
        FavoriteView(cryptoList: CryptoList(cryptos: Crypto.previewData))
    }
}
