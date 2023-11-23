//
//  FileManager.swift
//  Vibe
//
//  Created by Nicolas Bordeaux on 23/11/2023.
//

import Foundation

class FileManagerHelper {
    static let shared = FileManagerHelper()
    private let fileName = "CryptoList.json"

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func saveCryptoList(_ cryptoList: CryptoList) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try JSONEncoder().encode(cryptoList)
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to Save CryptoList: \(error.localizedDescription)")
        }
    }

    func loadCryptoList() -> CryptoList? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(CryptoList.self, from: data)
        } catch {
            print("Unable to Load CryptoList: \(error.localizedDescription)")
            return nil
        }
    }
}

