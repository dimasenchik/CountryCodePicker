//
//  CountryCodeTableViewCell.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit

final class CountryCodeTableViewCell: UITableViewCell, CountryCodeCellProtocol {
    
    // MARK: - Constants
    
    private struct Constants {
        // flagImageView
        static let flagImageViewSize: CGSize = CGSize(width: 28, height: 21)
        static let flagImageViewSideInset: CGFloat = 16
        // dialCodeLabel
        static let dialCodeLabelFont: UIFont = .systemFont(ofSize: 18, weight: .regular)
        static let dialCodeLabelColor: UIColor = .gray
        static let dialCodeLabelSideInset: CGFloat = 16
        // countryNameLabel
        static let countryNameLabelFont: UIFont = .systemFont(ofSize: 20, weight: .regular)
        static let countryNameLabelColor: UIColor = .black
        static let countryNameLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 18, left: 12, bottom: 18, right: 12)
        // checkboxImageView
        static let checkboxIconImage: UIImage = UIImage(named: "checkMarkIcon")!
        static let checkboxImageViewSize: CGSize = CGSize(width: 24, height: 24)
        static let checkboxImageViewSideInset: CGFloat = 16
    }
    
    // MARK: - Outlets
    
    private var flagImageView: UIImageView = UIImageView()
    private var dialCodeLabel: UILabel = UILabel()
    private var countryNameLabel: UILabel = UILabel()
    private var checkboxImageView: UIImageView = UIImageView()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with model: CountryCodeModel, isSelected: Bool) {
        flagImageView.image = model.flagImage
        dialCodeLabel.text = model.dialCode
        countryNameLabel.text = model.name
        checkboxImageView.isHidden = !isSelected
    }
    
    // MARK: - Private methods
    
    private func setupCell() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.addSubview(flagImageView)
        flagImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.flagImageViewSize)
            $0.left.equalToSuperview().inset(Constants.flagImageViewSideInset)
        }
        contentView.addSubview(dialCodeLabel)
        dialCodeLabel.font = Constants.dialCodeLabelFont
        dialCodeLabel.textColor = Constants.dialCodeLabelColor
        dialCodeLabel.textAlignment = .left
        dialCodeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(flagImageView.snp.right).inset(-Constants.dialCodeLabelSideInset)
        }
        contentView.addSubview(checkboxImageView)
        checkboxImageView.image = Constants.checkboxIconImage
        checkboxImageView.isHidden = true
        checkboxImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.checkboxImageViewSize)
            $0.right.equalToSuperview().inset(Constants.checkboxImageViewSideInset)
        }
        contentView.addSubview(countryNameLabel)
        countryNameLabel.font = Constants.countryNameLabelFont
        countryNameLabel.textColor = Constants.countryNameLabelColor
        countryNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.countryNameLabelInsets.top)
            $0.bottom.equalToSuperview().inset(Constants.countryNameLabelInsets.bottom)
            $0.left.equalTo(dialCodeLabel.snp.right).inset(-Constants.countryNameLabelInsets.left)
            $0.right.equalTo(checkboxImageView.snp.left).inset(-Constants.countryNameLabelInsets.right)
        }
    }
    
}
