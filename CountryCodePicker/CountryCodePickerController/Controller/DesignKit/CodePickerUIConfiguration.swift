//
//  CodePickerUIConfiguration.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit

public struct CodePickerUIConfiguration {
    
    // MARK: -  Default
    
    static public let defaultConfig: CodePickerUIConfiguration = .init(headerViewHeight: 54,
                                                                headerView: CountryCodeHeaderView(frame: .zero),
                                                                searchBarViewHeight: 100,
                                                                searchBarView: CountryCodeSearchBarView(frame: .zero),
                                                                tableViewBackgroundColor: .white,
                                                                tableViewCell: CountryCodeTableViewCell.self)
    
    // MARK: - Properties
    // headerView
    public let headerViewHeight: CGFloat
    public let headerView: CountryCodeHeaderProtocol
    // searchBarView
    public let searchBarViewHeight: CGFloat
    public let searchBarView: CountryCodeSearchBarProtocol
    // tableView
    public let tableViewBackgroundColor: UIColor
    public let tableViewCell: CountryCodeCellProtocol.Type
}
