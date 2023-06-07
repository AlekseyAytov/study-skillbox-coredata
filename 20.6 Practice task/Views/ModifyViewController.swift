//
//  ViewController.swift
//  19.5 Practice task
//
//  Created by Alex Aytov on 5/2/23.
//

import SnapKit
import RegexBuilder

class ModifyViewController: UIViewController {
    
    var artistFields: [ArtistProperties: String] = [:]
    
    var artistDob: Date?

    var doAfterEdit: (([ArtistProperties: String], Date) -> Void)?
    
    func setfields() {
        
        nameTextField.text = artistFields[.firstName]
        nameTextField.errorFlag = false
        
        lastnameTextField.text = artistFields[.lastName]
        lastnameTextField.errorFlag = false
        
        birthTextField.text = dateFormatter.string(from: artistDob!)
        birthTextField.errorFlag = false
        
        countryTextField.text = artistFields[.country]
        countryTextField.errorFlag = false
        
        occupationTextField.text = artistFields[.city]
        occupationTextField.errorFlag = false
        
        genderPicker.selectedSegmentIndex = Gender.allCases.map({ $0.rawValue }).firstIndex(of: artistFields[.gender]) ?? 0
    }
    
    private let counrtyRegex = Regex {
        OneOrMore(
            ChoiceOf{
                CharacterClass(.word)
                CharacterClass(.whitespace)
                "-"
                "'"
                ""
            }
        )
    }
    
    private let birthRegex = Regex {
        One(.anyOf("1,2"))
        Repeat(count: 3) {
            .digit
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextFieldStackView, lastnameTextFieldStackView, birthTextFieldStackView, genderPicker, countryTextFieldStackView, occupationTextFieldStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 25
        return stackView
    }()
    
// ----- name -----------------------------------
    
    
    private lazy var nameTextField: FloatingLabelInput = {
        let textField = FloatingLabelInput(floatingPlaceholder: "Имя")
        textField.delegate = self
        return textField
    }()
    
    private lazy var nameErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var nameTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, nameErrorLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- lastname ---------------------------------
    
    
    private lazy var lastnameTextField: FloatingLabelInput = {
        let textField = FloatingLabelInput(floatingPlaceholder: "Фамилия")
        textField.delegate = self
        return textField
    }()
    
    private lazy var lastnameErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var lastnameTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lastnameTextField, lastnameErrorLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- occupation -----------------------------
    
    private lazy var occupationTextField: FloatingLabelInput = {
        let textField = FloatingLabelInput(floatingPlaceholder: "Город")
        textField.delegate = self
        return textField
    }()
    
    private lazy var occupationErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var occupationTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [occupationTextField, occupationErrorLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- birth ----------------------------------
    
    private lazy var birthTextField: FloatingLabelInput = {
        let textField = FloatingLabelInput(floatingPlaceholder: "Дата рождения")
        textField.delegate = self
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var birthErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var birthTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [birthTextField, birthErrorLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- country --------------------------------
    
    private lazy var countryTextField: FloatingLabelInput = {
        let textField = FloatingLabelInput(floatingPlaceholder: "Страна")
        textField.delegate = self
        return textField
    }()
    
    private lazy var countryErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var countryTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryTextField, countryErrorLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var genderPicker: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: Gender.allCases.map{$0.rawValue} )
        segmentedControl.addTarget(self, action: #selector(genderPickerValueChanged), for: .valueChanged)
        segmentedControl.layer.borderColor = UIColor.lightGray.cgColor
        segmentedControl.layer.borderWidth  = 1
        return segmentedControl
    }()
    
// ----------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        
        let doneButton = UIBarButtonItem(title: "Сохрнить", style: .plain, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func doneTapped() {
        hideKeyboard()
        guard !nameTextField.errorFlag, !lastnameTextField.errorFlag, !occupationTextField.errorFlag, !birthTextField.errorFlag, !countryTextField.errorFlag else {
            
            // TODO: Сделать индикацую полей об отсутствии значений
            print("Заполните все поля")
            return
        }
        
        doAfterEdit?(artistFields, artistDob!)
        navigationController?.popViewController(animated: true)
    }
    
    private func hideKeyboard() {
        nameTextField.resignFirstResponder()
        lastnameTextField.resignFirstResponder()
        occupationTextField.resignFirstResponder()
        birthTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
    }
    
    @objc func genderPickerValueChanged(sender: UISegmentedControl) {
        artistFields[.gender] = Gender.allCases.map({ $0.rawValue })[sender.selectedSegmentIndex]
    }
}

// MARK: - UITextFieldDelegate

extension ModifyViewController: UITextFieldDelegate {
    
    // при нажатии на кнопку Return скрыть клавиатуру
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // в данном методе производится валидация значений при вводе
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // запрет ввода первого символа пробела
        if range.location == 0, string == " " { return false }
        
        // если редактируются поля-Не-наследники FloatingLabelInput, то разрешаем изменения
        guard let textField = textField as? FloatingLabelInput else { return true }

        // switch для определения конкретного поля, в котором происходит изменение
        switch textField {
        case nameTextField:
            if nameTextField.errorFlag {
                nameErrorLabel.isHidden = true
            }
            
//            TODO: сделать валидацию и присвоение значения во время ввода
//            var temp = (nameTextField.text ?? "") + string
//            if string == "" {
//                temp.remove(at: temp.index(before: temp.endIndex))
//            }
//            if let errorMessage = nameValueValidate(value: temp) {
//                nameTextField.errorFlag = true
//                nameErrorLabel.isHidden = false
//                nameErrorLabel.text = errorMessage
//            } else {
//                dataForSending[.name] = temp
//                nameTextField.errorFlag = false
//            }
            
            return true
        case lastnameTextField:
            if lastnameTextField.errorFlag {
                lastnameErrorLabel.isHidden = true
            }
            return true
        case occupationTextField:
            if occupationTextField.errorFlag {
                occupationErrorLabel.isHidden = true
            }
            return true
        case birthTextField:
            if birthTextField.errorFlag {
                birthErrorLabel.isHidden = true
            }
            
            var text = textField.text!
            
            // запрет изменения строки, если курсор находиться не в конце
            // запрет на вставку
            if (range.location + 1) < text.count || string.count > 1 {
                return false
            }
            
            switch range.location {
            case 1, 4:
                if string != "" {
                    textField.text! = text + string + "."
                    return false
                }
            case 2, 5 :
                if string != "" {
                    textField.text! = text + "."
                } else {
                    text.remove(at: text.index(text.startIndex, offsetBy: range.location-1))
                    textField.text! = text
                }
            case 3, 6:
                if string.isEmpty {
                    text.remove(at: text.index(text.startIndex, offsetBy: range.location-1))
                    textField.text! = text
                }
            case 10... :
                if string != "" {
                    return false
                }
            default:
                break
            }
            
            return true
            
        case countryTextField:
            if countryTextField.errorFlag {
                countryErrorLabel.isHidden = true
            }
            
            // если нет ни одного совпадения с counrtyRegex, то запрещаем изменение
            guard let _ = string.firstMatch(of: counrtyRegex) else { return false }
            
            return true
        default:
            // если редактируются поля, не указанные выше, то разрешаем изменения
            return true
        }
    }
    
//    TODO: сделать валидацию и присвоение значения во время ввода
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        switch textField {
//        case nameTextField:
//            dataForSending[.name] = nil
//            return true
//        default:
//            return true
//        }
//    }
    
    // в методе производится валидация введенных в поля значений и присвоение этих значений локальной модели
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameTextField:
            if let errorMessage = nameValueValidate(value: nameTextField.text) {
                nameTextField.errorFlag = true
                nameErrorLabel.isHidden = false
                nameErrorLabel.text = errorMessage
            } else {
                nameTextField.errorFlag = false
                artistFields[.firstName] = nameTextField.text!
            }
        case lastnameTextField:
            if let errorMessage = lastnameValueValidate(value: lastnameTextField.text) {
                lastnameTextField.errorFlag = true
                lastnameErrorLabel.isHidden = false
                lastnameErrorLabel.text = errorMessage
            } else {
                lastnameTextField.errorFlag = false
                artistFields[.lastName] = lastnameTextField.text!
            }
        case occupationTextField:
            if let errorMessage = occupationValueValidate(value: occupationTextField.text) {
                occupationTextField.errorFlag = true
                occupationErrorLabel.isHidden = false
                occupationErrorLabel.text = errorMessage
            } else {
                occupationTextField.errorFlag = false
                artistFields[.city] = occupationTextField.text!
            }
        case birthTextField:
            if let errorMessage = birthValueValidate(value: birthTextField.text) {
                birthTextField.errorFlag = true
                birthErrorLabel.isHidden = false
                birthErrorLabel.text = errorMessage
            } else {
                birthTextField.errorFlag = false
                artistDob = dateFormatter.date(from: birthTextField.text!)
            }
        case countryTextField:
            if let errorMessage = countryValueValidate(value: countryTextField.text) {
                countryTextField.errorFlag = true
                countryErrorLabel.isHidden = false
                countryErrorLabel.text = errorMessage
            } else {
                countryTextField.errorFlag = false
                artistFields[.country] = countryTextField.text!
            }
        default:
            return true
        }
        
        return true
    }
    
//  MARK: - Функции валидации введенных значений
    func nameValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            return nil
        } else {
            return "Заполните поле"
        }
    }
    
    func lastnameValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            return nil
        } else {
            return "Заполните поле"
        }
    }
    
    func occupationValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            return nil
        } else {
            return "Заполните поле"
        }
    }
    
    func birthValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            
            // проверка на совпадение регулярному выражению
//            if let _ = value.wholeMatch(of: birthRegex) {
//                return nil
//            } else {
//                return "Введите год"
//            }
                        
            if let date = dateFormatter.date(from: value) {
                if date > Date() {
                    return "Неверная дата"
                }
            } else {
                return "Неверный формат"
            }
            return nil
        } else {
            return "Заполните поле"
        }
    }
    
    func countryValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            if let _ = value.wholeMatch(of: counrtyRegex) {
                return nil
            } else {
                return "Не может содержать символов"
            }
        } else {
            return "Заполните поле"
        }
    }
}
