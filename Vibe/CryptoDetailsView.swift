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
        // Perform API request to fetch cryptocurrency info here
        fetchCryptoInfo()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(crypto.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            // Display cryptocurrency info if available
            if let info = crypto.cryptoInfo?.data[crypto.name]?.first {
                Text(info.description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                
                
                
                
                Text("Category: \(info.category)")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
            }
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
                Toggle("Possédée", isOn: $crypto.isOwned)
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
            hideKeyboard()
        }
        .onAppear {
            editingPrice = String(format: "%.2f", crypto.price)
        }
    }
    
    private func hideKeyboard() {
        isPriceFieldFocused = false
    }
    
    private func fetchCryptoInfo() {
        // Define the API endpoint URL
        let apiUrl = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info"
        
        // Define your API key
        let apiKey = "0a1a761c-b91d-47f5-9386-3d4837afc72a" // Replace with your actual CoinMarketCap API key
        
        // Define the cryptocurrency symbol
        let symbol = crypto.name // Use the symbol instead of name
        
        // Create the URL with query parameters
        if let url = URL(string: "\(apiUrl)?CMC_PRO_API_KEY=\(apiKey)&symbol=\(symbol)") {
            // Create a URLRequest with the URL
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // Perform the API request using URLSession
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        // Parse the JSON response into the CryptoInfo struct
                        
                        let decoder = JSONDecoder()
                        let info = try decoder.decode(CryptoInfo.self, from: data)
                        DispatchQueue.main.async {
                            self.crypto.cryptoInfo = info
                            
                            
                        }
                        
                    } catch {
                        // Handle parsing errors
                        print("Error parsing JSON: \(error)")
                    }
                } else if let error = error {
                    // Handle network errors
                    print("Network error: \(error)")
                }
            }.resume()
        }
    }
}

struct CryptoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailsView(crypto: Crypto.previewData[0])
    }
}
