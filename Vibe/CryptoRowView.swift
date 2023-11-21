//
//  CryptoRowView.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 20/11/2023.
//

import SwiftUI

struct CryptoRowView: View {
    @ObservedObject var crypto: Crypto

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: crypto.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(crypto.name)
                Text("Prix: \(String(format: "%.2f", crypto.price))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: crypto.isOwned ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(crypto.isOwned ? .green : .red)
        }
    }
}
