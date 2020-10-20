//
//  CountryCodeSearchBarProtocol.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit

public protocol CountryCodeSearchBarProtocol where Self: UIView {
    var textDidChange: ((String) -> Void)? { get set }
}
