//
//  CryptoDetailsView.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 21/11/2023.
//

import SwiftUI

struct CryptoDetailsView: View {
    @ObservedObject var crypto: Crypto
    @State private var editingPrice: String
    @FocusState private var isPriceFieldFocused: Bool
    
    init(crypto: Crypto) {
        self.crypto = crypto
        _editingPrice = State(initialValue: String(format: "%.2f", crypto.price))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(crypto.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            AsyncImage(url: URL(string: crypto.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .cornerRadius(10)
            
            VStack {
                Text("Prix")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Entrez le nouveau prix", text: $editingPrice)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isPriceFieldFocused)
                    .onChange(of: editingPrice) {
                        if let newPrice = Float(editingPrice) {
                            crypto.price = newPrice
                        }
                    }
            }
            .padding(.horizontal)
            
            VStack {
                Toggle("Possédée",isOn: $crypto.isOwned)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    .padding()
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle(crypto.name)
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            hideKeyboard() // Masquer le clavier lorsque l'utilisateur appuie n'importe où en dehors du clavier
        }
        .onAppear {
            
            editingPrice = String(format: "%.2f", crypto.price)
        }
    }
    
    private func hideKeyboard() {
        isPriceFieldFocused = false
    }
}




struct CryptoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailsView(crypto: Crypto.previewData[0])
    }
}


