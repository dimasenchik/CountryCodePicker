//
//  CountryCodeModel.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit

open class CountryCodeModel: Codable {
    
    // MARK: - Properties
    
    let id: Int
    let name: String
    let dialCode: String
    let isoCode: String
    let digits: [Int]
    
    // MARK: - Initialization
    
    init(id: Int, name: String, dialCode: String, isoCode: String, digits: [Int]) {
        self.id = id
        self.name = name
        self.dialCode = dialCode
        self.isoCode = isoCode
        self.digits = digits
    }
    
}

extension CountryCodeModel {
    var flagImage: UIImage? {
        return UIImage(named: isoCode)
    }
    
    func isValid(phoneNumber: String) -> Bool {
        return digits.contains(phoneNumber.count)
    }
}
