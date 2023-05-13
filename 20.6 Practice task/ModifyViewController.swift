//
//  ViewController.swift
//  19.5 Practice task
//
//  Created by Alex Aytov on 5/2/23.
//

import SnapKit
import RegexBuilder

class ModifyViewController: UIViewController {
    
    var artist: ArtistProtocol = Artist(gender: .male, firstName: "", lastName: "", dob: "", country: "", city: "")

    var doAfterEdit: ((ArtistProtocol) -> Void)?
    
    func setfields() {
        
        nameTextField.text = artist.firstName
        nameTextField.errorFlag = false
        
        lastnameTextField.text = artist.lastName
        lastnameTextField.errorFlag = false
        
        birthTextField.text = artist.dob
        birthTextField.errorFlag = false
        
        countryTextField.text = artist.country
        countryTextField.errorFlag = false
        
        occupationTextField.text = artist.city
        occupationTextField.errorFlag = false
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
    
    private lazy var aboutInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Constants.Titles.aboutinfo
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
// ----- name -----------------------------------
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Titles.name
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var nameTextField: CustomUITextField = {
        let textField = CustomUITextField()
        textField.delegate = self
        return textField
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 3
        return stackView
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- lastname ---------------------------------
    
    private lazy var lastnameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Titles.lastname
        return label
    }()
    
    private lazy var lastnameTextField: CustomUITextField = {
        let textField = CustomUITextField()
        textField.delegate = self
        return textField
    }()
    
    private lazy var lastnameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- occupation -----------------------------
    
    private lazy var occupationLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Titles.occupation
        return label
    }()
    
    private lazy var occupationTextField: CustomUITextField = {
        let textField = CustomUITextField()
        textField.delegate = self
        return textField
    }()
    
    private lazy var occupationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- birth ----------------------------------
    
    private lazy var birthLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Titles.birth
        return label
    }()
    
    private lazy var birthTextField: CustomUITextField = {
        let textField = CustomUITextField()
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.textContentType = .dateTime
        return textField
    }()
    
    private lazy var birthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- country --------------------------------
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Titles.country
        return label
    }()
    
    private lazy var countryTextField: CustomUITextField = {
        let textField = CustomUITextField()
        textField.delegate = self
        return textField
    }()
    
    private lazy var countryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
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
        navigationItem.title = "Заголовок сцены"
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))

        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(aboutInfo)
        
        stackView.addArrangedSubview(nameStackView)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextFieldStackView)
        nameTextFieldStackView.addArrangedSubview(nameTextField)
        nameTextFieldStackView.addArrangedSubview(nameErrorLabel)

        stackView.addArrangedSubview(lastnameStackView)
        lastnameStackView.addArrangedSubview(lastnameLabel)
        lastnameStackView.addArrangedSubview(lastnameTextFieldStackView)
        lastnameTextFieldStackView.addArrangedSubview(lastnameTextField)
        lastnameTextFieldStackView.addArrangedSubview(lastnameErrorLabel)

        stackView.addArrangedSubview(occupationStackView)
        occupationStackView.addArrangedSubview(occupationLabel)
        occupationStackView.addArrangedSubview(occupationTextFieldStackView)
        occupationTextFieldStackView.addArrangedSubview(occupationTextField)
        occupationTextFieldStackView.addArrangedSubview(occupationErrorLabel)

        stackView.addArrangedSubview(birthStackView)
        birthStackView.addArrangedSubview(birthLabel)
        birthStackView.addArrangedSubview(birthTextFieldStackView)
        birthTextFieldStackView.addArrangedSubview(birthTextField)
        birthTextFieldStackView.addArrangedSubview(birthErrorLabel)
        
        stackView.addArrangedSubview(countryStackView)
        countryStackView.addArrangedSubview(countryLabel)
        countryStackView.addArrangedSubview(countryTextFieldStackView)
        countryTextFieldStackView.addArrangedSubview(countryTextField)
        countryTextFieldStackView.addArrangedSubview(countryErrorLabel)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        lastnameLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        occupationLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
    }
    
    @objc func doneTapped() {
        hideKeyboard()
        guard !nameTextField.errorFlag, !lastnameTextField.errorFlag, !occupationTextField.errorFlag, !birthTextField.errorFlag, !countryTextField.errorFlag else {
            
            // TODO: Сделать индикацую полей об отсутствии значений
            print("Заполните все поля")
            return
        }
        
        doAfterEdit?(artist)
        navigationController?.popViewController(animated: true)
    }
    
    private func hideKeyboard() {
        nameTextField.resignFirstResponder()
        lastnameTextField.resignFirstResponder()
        occupationTextField.resignFirstResponder()
        birthTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
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
        
        print("------------")
        print("range.location - \(range.location)")
        print("string - \(string)")
        
        
        // запрет ввода первого символа пробела
        if range.location == 0, string == " " { return false }
        
        // если редактируются поля-Не-наследники CustomUITextField, то разрешаем изменения
        guard let textField = textField as? CustomUITextField else { return true }

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
            
            // если вводимая строка пустая, то разрешаем изменение
            if string.isEmpty { return true }
            // если вводимая строка не приводиться к типу Int, то запрещаем изменения
            guard let _ = Int(string) else { return false }
            // если в поле более 4 символов, то запрещаем изменение
            if range.location >= 4 { return false }
            
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
                artist.firstName = nameTextField.text!
            }
        case lastnameTextField:
            if let errorMessage = lastnameValueValidate(value: lastnameTextField.text) {
                lastnameTextField.errorFlag = true
                lastnameErrorLabel.isHidden = false
                lastnameErrorLabel.text = errorMessage
            } else {
                lastnameTextField.errorFlag = false
                artist.lastName = lastnameTextField.text!
            }
        case occupationTextField:
            if let errorMessage = occupationValueValidate(value: occupationTextField.text) {
                occupationTextField.errorFlag = true
                occupationErrorLabel.isHidden = false
                occupationErrorLabel.text = errorMessage
            } else {
                occupationTextField.errorFlag = false
                artist.city = occupationTextField.text!
            }
        case birthTextField:
            if let errorMessage = birthValueValidate(value: birthTextField.text) {
                birthTextField.errorFlag = true
                birthErrorLabel.isHidden = false
                birthErrorLabel.text = errorMessage
            } else {
                birthTextField.errorFlag = false
                artist.dob = birthTextField.text!
            }
        case countryTextField:
            if let errorMessage = countryValueValidate(value: countryTextField.text) {
                countryTextField.errorFlag = true
                countryErrorLabel.isHidden = false
                countryErrorLabel.text = errorMessage
            } else {
                countryTextField.errorFlag = false
                artist.country = countryTextField.text!
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
            if let _ = value.wholeMatch(of: birthRegex) {
                return nil
            } else {
                return "Введите год"
            }
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
