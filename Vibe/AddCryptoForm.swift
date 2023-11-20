//
//  AddCryptoForm.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 20/11/2023.
//

import SwiftUI

struct AddCryptoForm: View {
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var imageUrl: String = ""
    @State private var isOwned: Bool = false
    @Environment(\.presentationMode) var presentationMode
    var onSave: (Crypto) -> Void
    var crypto: Crypto?

    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $name)
                TextField("Prix", text: $price)
                    .keyboardType(.decimalPad)
                TextField("URL de l'Image", text: $imageUrl)
                Toggle("Possédée", isOn: $isOwned)
                Button(crypto == nil ? "Ajouter Crypto" : "Enregistrer les Modifications") {
                    if let priceFloat = Float(price), !name.isEmpty, !imageUrl.isEmpty {
                        let newOrEditedCrypto = Crypto(name: name, price: priceFloat, imageUrl: imageUrl, isOwned: isOwned)
                        onSave(newOrEditedCrypto)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle(crypto == nil ? "Ajouter une Crypto" : "Modifier la Crypto")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                if let crypto = crypto {
                    name = crypto.name
                    price = String(crypto.price)
                    imageUrl = crypto.imageUrl
                    isOwned = crypto.isOwned
                }
            }
        }
    }
}
