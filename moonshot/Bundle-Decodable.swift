//
//  Bundle-Decodable.swift
//  moonshot
//
//  Created by Travis Brigman on 2/8/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import Foundation


extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to locate \(file) in bundle.")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to locate \(file) in bundle.")
        }
        
        return loaded
    }
}
