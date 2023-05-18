//
//  FloatingLabelInput.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/16/23.
//

import UIKit

class FloatingLabelInput: UITextField {
    
    // для правильного позиционирования нужно задать постоянную ширину
    let floatingLabelWidth: CGFloat = 200
    
    // TODO: сделать динамическую установку высоты расположения floatingLabel в зависимости от высоты FloatingLabelInput
    let floatingLabelPosition: CGFloat = -25
    
    var errorFlag: Bool = true

    lazy var floatingLabel = UILabel()
    
    // Нужен, если свойство text устанавливается до добавления FloatingLabelInput в иерархию view
    override var text: String? {
        didSet {
            if text != "" {
                removeLabelFromPlaceholder()
            }
        }
    }
    
    init(floatingPlaceholder: String) {
        super.init(frame: .zero)
        
        floatingLabel.text = floatingPlaceholder
        setupView()
        normalBorderStile()
        setPlaceholder()
        self.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        borderStyle = .roundedRect
        clearButtonMode = .whileEditing
        returnKeyType = .done
        autocapitalizationType = .sentences
        autocorrectionType = .no
        spellCheckingType = .no
        smartQuotesType = .no
        smartDashesType = .no
        smartInsertDeleteType = .no
    }
    
    private func normalBorderStile() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth  = 1
        layer.cornerRadius = 4
    }
    
    private func errorBorderStile() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth  = 2
        layer.cornerRadius = 4
    }
    
    private func editingBorderStile() {
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth  = 2
        layer.cornerRadius = 4
    }
    
    private func setPlaceholder() {
        addSubview(floatingLabel)
        floatingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(8 - floatingLabelWidth/2)
            make.width.equalTo(floatingLabelWidth)
        }
        
        floatingLabel.alpha = 0.5
        // При смене anchorPoint для правильного позиционирования нужно задать постоянную ширину
        floatingLabel.anchorPoint = CGPoint(x: 0, y: 0.5)
    }
    
    private func setLabelToPlaceholder() {
        
        floatingLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.floatingLabel.alpha = 0.5
            self.floatingLabel.transform = .identity
            self.layoutIfNeeded()
        }
    }
    
    private func removeLabelFromPlaceholder() {
        floatingLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(floatingLabelPosition)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.floatingLabel.alpha = 1
            self.floatingLabel.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.layoutIfNeeded()
        }
    }
    
    func isValueExist() -> Bool {
        guard let textValue = self.text, !textValue.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
    
    @objc func textFieldEditingDidBegin() {
        editingBorderStile()
        
        if self.text == "" {
            removeLabelFromPlaceholder()
        }
    }
    
    @objc func textFieldEditingDidEnd() {
        
        if !self.errorFlag {
            normalBorderStile()
        } else {
            errorBorderStile()
        }
        
        if self.text == "" {
            setLabelToPlaceholder()
        }
    }
}
