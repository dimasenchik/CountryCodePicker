//
//  CountryCodeHeaderProtocol.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit

public protocol CountryCodeHeaderProtocol where Self: UIView {
    var didTapOnDismiss: VoidHandler? { get set }
}
