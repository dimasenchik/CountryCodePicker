//
//  CountryCodeSearchBarView.swift
//  CountryCodePicker
//
//  Created by Dima Senchik on 20.10.2020.
//

import UIKit

final class CountryCodeSearchBarView: UIView, CountryCodeSearchBarProtocol {
    
    // MARK: - Constants
    
    private struct Constants {
        static let backgroundColor: UIColor = .white
        // bodyView
        static let bodyViewCornerRadius: CGFloat = 4
        static let bodyViewBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.15)
        static let bodyViewInsets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        // searchIconImageView
        static let searchIconImage: UIImage = UIImage(named: "search_icon")!
        static let searchIconImageViewSize: CGSize = CGSize(width: 20, height: 20)
        static let searchIconImageViewSideInset: CGFloat = 16
        // inputTextField
        static let inputTextFieldPlaceholderFont: UIFont = .systemFont(ofSize: 16, weight: .regular)
        static let inputTextFieldFont: UIFont = .systemFont(ofSize: 16, weight: .semibold)
        static let inputTextFieldColor: UIColor = UIColor.black.withAlphaComponent(0.75)
        static let inputTextFieldSideInset: CGFloat = 12
        // clearTextButton
        static let clearTextIconImage: UIImage = UIImage(named: "closeIcon")!
        static let clearTextButtonSize: CGSize = CGSize(width: 20, height: 20)
        static let clearTextButtonSideInset: CGFloat = 16
    }
    
    // MARK: - Outlets
    
    private var bodyView: UIView = UIView()
    private var searchIconImageView: UIImageView = UIImageView()
    private var inputTextField: UITextField = UITextField()
    private var clearTextButton: UIButton = UIButton()
    
    // MARK: - Properties
    
    var textDidChange: ((String) -> Void)?
    
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
        addSubview(bodyView)
        bodyView.layer.cornerRadius = Constants.bodyViewCornerRadius
        bodyView.backgroundColor = Constants.bodyViewBackgroundColor
        bodyView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(Constants.bodyViewInsets.top)
        }
        bodyView.addSubview(searchIconImageView)
        searchIconImageView.image = Constants.searchIconImage
        searchIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(Constants.searchIconImageViewSideInset)
            $0.size.equalTo(Constants.searchIconImageViewSize)
        }
        bodyView.addSubview(inputTextField)
        inputTextField.font = Constants.inputTextFieldPlaceholderFont
        inputTextField.textColor = Constants.inputTextFieldColor
        inputTextField.textAlignment = .left
        inputTextField.addTarget(self, action: #selector(inputTextFieldDidChange), for: .valueChanged)
        inputTextField.addTarget(self, action: #selector(inputTextFieldEditingBegin), for: .editingDidBegin)
        inputTextField.addTarget(self, action: #selector(inputTextFieldEditingEnd), for: .editingDidEnd)
        inputTextField.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(searchIconImageView.snp.right).inset(-Constants.inputTextFieldSideInset)
        }
        bodyView.addSubview(clearTextButton)
        clearTextButton.setImage(Constants.clearTextIconImage, for: .normal)
        clearTextButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.clearTextButtonSize)
            $0.right.equalToSuperview().inset(Constants.clearTextButtonSideInset)
        }
    }
    
    // MARK: - User Interaction
    
    @objc private func inputTextFieldDidChange() {
        guard let inputText = inputTextField.text else { return }
        clearTextButton.isHidden = inputText.isEmpty
        textDidChange?(inputText)
    }
    
    @objc private func inputTextFieldEditingBegin() {
        searchIconImageView.snp.updateConstraints {
            $0.left.equalToSuperview().inset(-Constants.searchIconImageViewSize.width)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func inputTextFieldEditingEnd() {
        searchIconImageView.snp.updateConstraints {
            $0.left.equalToSuperview().inset(Constants.searchIconImageViewSideInset)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
}
