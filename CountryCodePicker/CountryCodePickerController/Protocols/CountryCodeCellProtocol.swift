//
//  CountryCodeCellProtocol.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit

public protocol CountryCodeCellProtocol where Self: UITableViewCell {
    func configure(with model: CountryCodeModel, isSelected: Bool)
}
