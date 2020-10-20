//
//  CountryCodePickerController.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit
import SnapKit

// MARK: - CountryCodePickerDelegate

public protocol CountryCodePickerDelegate {
    func countryCodePicker(controller: CountryCodePickerController, didSelect countryCode: CountryCodeModel)
    func countryCodePicker(didDismiss controller: CountryCodePickerController)
}

// MARK: - CountryCodePickerController

open class CountryCodePickerController: UIViewController {
    
    // MARK: - Outlets
    
    private var headerView: UIView = UIView()
    private var tableView: UITableView = UITableView()
    
    // MARK: - Properties
    
    var preSelectedCode: CountryCodeModel?
    var exceptionalISOCodes: [String] = [] {
        didSet {
            availableCountryCodes = CountryCodeService.getCodes().filter {
                !exceptionalISOCodes.map { $0.lowercased() }.contains($0.isoCode.lowercased())
            }
        }
    }
    var displayableISOCodes: [String] = [] {
        didSet {
            availableCountryCodes = CountryCodeService.getCodes().filter {
                displayableISOCodes.map { $0.lowercased() }.contains($0.isoCode.lowercased())
            }
        }
    }
    private var availableCountryCodes: [CountryCodeModel] = CountryCodeService.getCodes()
    private var filteredCountryCodes: [CountryCodeModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var uiConfiguration: CodePickerUIConfiguration
    
    // MARK: - Callbacks
    
    var didSelectCountryCode: ((CountryCodeModel) -> Void)?
    var didDismiss: VoidHandler?
    
    // MARK: - Initialization
    
    init(uiConfiguration: CodePickerUIConfiguration = .defaultConfig) {
        self.uiConfiguration = uiConfiguration
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        
    }
    
}
