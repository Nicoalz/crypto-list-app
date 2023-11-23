//
//  AddCryptoForm.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 20/11/2023.
//

import SwiftUI

enum NameInputType {
    case picker
    case custom
}

struct AddCryptoForm: View {
    @ObservedObject var cryptoList: CryptoList
    @Binding var showingForm: Bool
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var imageUrl: String = ""
    @State private var isOwned: Bool = false
    @State private var nameInputType: NameInputType = .picker
    let cryptoNamesAvailable = ["BTC","ETH","USDT","BNB","XRP","SOL","USDC","DOGE", "Custom"]
    
    var body: some View {
        NavigationView {
            Form {
                if nameInputType == .picker {
                    Picker("Nom", selection: $name) {
                        ForEach(cryptoNamesAvailable, id: \.self) { name in
                            Text(name).tag(name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: name) {
                        if name == "Custom" {
                            nameInputType = .custom
                            name = ""
                        }
                    }
                } else {
                    TextField("Nom", text: $name)
                }
                TextField("Prix", text: $price)
                    .keyboardType(.decimalPad)
                TextField("URL de l'Image", text: $imageUrl)
                Toggle("Possédée", isOn: $isOwned)
                Button("Ajouter Crypto") {
                    if let priceFloat = Float(price), !name.isEmpty, !imageUrl.isEmpty {
                        let newCrypto = Crypto(name: name, price: priceFloat, imageUrl: imageUrl, isOwned: isOwned)
                        cryptoList.cryptos.append(newCrypto)
                        showingForm = false
                        FileManagerHelper.shared.saveCryptoList(cryptoList)
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
