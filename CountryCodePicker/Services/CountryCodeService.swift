//
//  CountryCodeService.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import Foundation

open class CountryCodeService {
    
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
    
    static func getSpecificCode(isoCode: String? = nil, dialCode: String? = nil, id: Int? = nil) -> CountryCodeModel? {
        return getCodes().first { $0.isoCode == isoCode || $0.dialCode == dialCode || $0.id == id }
    }
    
}
