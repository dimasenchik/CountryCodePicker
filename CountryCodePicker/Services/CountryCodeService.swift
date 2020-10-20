//
//  CountryCodeService.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import Foundation

final class CountryCodeService {
    
    // MARK: - Public methods
    
    static func getCodes() -> [CountryCodeModel] {
        if let url = Bundle.main.url(forResource: "CountryCodes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode([CountryCodeModel].self, from: data)
            } catch {
                return []
            }
        }
        return []
    }
    
}
