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
    
    private var tableView: UITableView = UITableView()
    
    // MARK: - Properties
    
    var delegate: CountryCodePickerDelegate?
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
    
    public init(uiConfiguration: CodePickerUIConfiguration = .defaultConfig) {
        self.uiConfiguration = uiConfiguration
        super.init(nibName: nil, bundle: nil)
        
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        availableCountryCodes.sort { $0.name < $1.name }
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        // headerView
        view.addSubview(uiConfiguration.headerView)
        uiConfiguration.headerView.didTapOnDismiss = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.countryCodePicker(didDismiss: strongSelf)
            strongSelf.didDismiss?()
        }
        uiConfiguration.headerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(uiConfiguration.headerViewHeight)
        }
        // searchBar
        view.addSubview(uiConfiguration.searchBarView)
        uiConfiguration.searchBarView.textDidChange = { [weak self] newValue in
            if newValue.isEmpty {
                self?.filteredCountryCodes = self?.availableCountryCodes ?? []
            } else {
                self?.filteredCountryCodes = self?.availableCountryCodes.filter {
                    $0.dialCode.lowercased().contains(newValue.lowercased()) || $0.name.lowercased().contains(newValue.lowercased())
                } ?? []
            }
        }
        uiConfiguration.searchBarView.snp.makeConstraints {
            $0.height.equalTo(uiConfiguration.searchBarViewHeight)
            $0.top.equalTo(uiConfiguration.headerView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        // tableView
        view.addSubview(tableView)
        tableView.backgroundColor = uiConfiguration.tableViewBackgroundColor
        tableView.tableFooterView = UIView()
        tableView.register(cell: uiConfiguration.tableViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints {
            $0.top.equalTo(uiConfiguration.searchBarView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - User Interaction
    
    @objc private func didTapOnClose() {
        delegate?.countryCodePicker(didDismiss: self)
        didDismiss?()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CountryCodePickerController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountryCodes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCodeCellProtocol") as! CountryCodeCellProtocol
        cell.configure(with: filteredCountryCodes[indexPath.row],
                       isSelected: filteredCountryCodes[indexPath.row].id == preSelectedCode?.id)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCountryCode?(filteredCountryCodes[indexPath.row])
        delegate?.countryCodePicker(controller: self, didSelect: filteredCountryCodes[indexPath.row])
    }
}
