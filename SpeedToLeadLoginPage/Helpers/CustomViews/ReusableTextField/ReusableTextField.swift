//
//  ReusableTextField.swift
//  SpeedToLeadLoginPage
//
//  Created by Evgeniy Chernyshov on 16.06.2022.
//

import UIKit

//For auto-update button state, when TF is editing
protocol ReusableTextFieldEditingChangedDelegate: class {
    func editingChanged()
}
    
@IBDesignable
class ReusableTextField: UIView, ReusableTextFieldProtocol, NibLoadable {
    
    //MARK: - Outlets and properties
    
    @IBOutlet weak var placeholderDescriptionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var inactivePlaceholderLabel: UILabel!
    
    @IBOutlet weak var activeFilledStateView: UIView!
    @IBOutlet weak var inactiveUnfilledStateView: UIView!
    
    var nibName: String
    var className: AnyClass
    
    var rightAction: (() -> Void)?
    var textFieldDidChange: (() -> Void)?
    
    var delegate: ReusableTextFieldEditingChangedDelegate?
    
    // MARK: - Constructor
    
    public required init?(coder: NSCoder) {
        nibName = String(describing: ReusableTextField.self)
        className = ReusableTextField.self
        super.init(coder: coder)
        setupFromNib()
        configureViewsStyle()
    }
    
    public override init(frame: CGRect) {
        nibName = String(describing: ReusableTextField.self)
        className = ReusableTextField.self
        super.init(frame: frame)
        setupFromNib()
        configureViewsStyle()
    }

    override func prepareForInterfaceBuilder() {
        configureViewsStyle()
    }
    
    //MARK: - Configure UI and State
    
    func changeTextFieldState(state: ReusableTextFieldState) {
        switch state {
        case .unfilled:
            clearTextField()
            inactiveUnfilledStateView.isHidden = false
            activeFilledStateView.isHidden = true
            textField.resignFirstResponder()
        case .filled:
            activeFilledStateView.isHidden = false
            inactiveUnfilledStateView.isHidden = true
            textField.becomeFirstResponder()
        }
    }
    
    func configure(textFieldName: String, keyboardType: UIKeyboardType?, isSecureTextEntry: Bool, placeholder: String?, buttonImage: UIImage?) {
        placeholderDescriptionLabel.text = textFieldName
        rightButton.imageView?.image = buttonImage
        rightButton.setImage(buttonImage, for: .normal)
        rightButton.tintColor = UIColor.init(named: "darkGrayFont")
        inactivePlaceholderLabel.text = placeholder
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecureTextEntry
        
        if let keyboardType = keyboardType {
            textField.keyboardType = keyboardType
        }
    }
    
    //MARK: - Actions
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        rightAction?()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        changeTextFieldState(state: .filled)
    }

    @IBAction func textFieldDidChange(_ sender: UITextField) {
        delegate?.editingChanged()
    }
    
    
    //MARK: - Text field functions
    
    func clearTextField() {
        textField.text = ""
        textField.becomeFirstResponder()
    }
    
    func checkState() {
        checkTextFieldState()
    }
    
    private func checkTextFieldState() {
            self.textField.text == "" ? self.changeTextFieldState(state: .unfilled) :  self.changeTextFieldState(state: .filled)
    }
    
    func showSecureText() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    func editingChanged() {
        delegate?.editingChanged()
    }
    
    //MARK: - Style
    
    private func configureViewsStyle() {
        activeFilledStateView.layer.borderWidth = 2
        activeFilledStateView.layer.borderColor = UIColor(named: "TFBorderGrayColor")?.cgColor
        activeFilledStateView.layer.cornerRadius = 10
        inactiveUnfilledStateView.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        inactiveUnfilledStateView.addGestureRecognizer(tap)
    }
}

