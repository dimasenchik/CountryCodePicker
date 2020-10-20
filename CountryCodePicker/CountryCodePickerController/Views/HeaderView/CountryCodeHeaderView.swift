//
//  CountryCodeHeaderView.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit

final class CountryCodeHeaderView: UIView, CountryCodeHeaderProtocol {
    
    // MARK: - Constants
    
    private struct Constants {
        static let backgroundColor: UIColor = .white
        // closeButton
        static let closeIconImage: UIImage = UIImage(named: "closeIcon")!
        static let closeButtonSize: CGSize = CGSize(width: 24, height: 24)
        static let closeButtonSideInset: CGFloat = 16
        // titleLabel
        static let titleLabelFont: UIFont = .systemFont(ofSize: 16, weight: .semibold)
        static let titleLabelColor: UIColor = .black
    }
    
    // MARK: - Outlets
    
    private var closeButton: UIButton = UIButton()
    private var titleLabel: UILabel = UILabel()
    
    // MARK: - Properties
    
    var didTapOnDismiss: VoidHandler?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = Constants.backgroundColor
        addSubview(closeButton)
        closeButton.setImage(Constants.closeIconImage, for: .normal)
        closeButton.addTarget(self, action: #selector(didTapOnCloseButton), for: .touchUpInside)
        closeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.closeButtonSize)
            $0.left.equalToSuperview().inset(Constants.closeButtonSideInset)
        }
        addSubview(titleLabel)
        titleLabel.font = Constants.titleLabelFont
        titleLabel.textColor = Constants.titleLabelColor
        titleLabel.text = "Country code"
        titleLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    // MARK: - User Interaction
    
    @objc private func didTapOnCloseButton() {
        didTapOnDismiss?()
    }
    
    
}
