//
//  AddCryptoForm.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 20/11/2023.
//

import SwiftUI

struct AddCryptoForm: View {
    @ObservedObject var cryptoList: CryptoList
    @Binding var showingForm: Bool
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var imageUrl: String = ""
    @State private var isOwned: Bool = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $name)
                TextField("Prix", text: $price)
                    .keyboardType(.decimalPad)
                TextField("URL de l'Image", text: $imageUrl)
                Toggle("Possédée", isOn: $isOwned)
                Button("Ajouter Crypto") {
                    if let priceFloat = Float(price), !name.isEmpty, !imageUrl.isEmpty {
                        let newCrypto = Crypto(name: name, price: priceFloat, imageUrl: imageUrl, isOwned: isOwned)
                        cryptoList.cryptos.append(newCrypto)
                        showingForm = false
                    }
                }
            }
            .navigationTitle("Ajouter une Crypto")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        showingForm = false
                    }
                }
            }
        }
    }
}
