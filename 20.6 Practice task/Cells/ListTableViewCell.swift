//
//  ListTableViewCell.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/11/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "List cell"
    
    var name: String? {
        willSet {
            postHeaderLabel.text = newValue
        }
    }
    
    var dob: String? {
        willSet {
            postTimeLabel.text = newValue
        }
    }
    
    var country: String? {
        willSet {
            postTextLabel.text = newValue
        }
    }

    // главный горизонтальный стэк ячейки
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [postImage, postStack])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .top
        return stack
    }()
    
    private lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Constants.Colors.gray01
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // вертикальный стэк для поста
    private lazy var postStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [postHeaderLabel, postHeaderStack, postFooterView])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    // горизонтальный стэк для загловка поста
    private lazy var postHeaderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [postTextLabel, postTimeLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var postTextLabel: UILabel = {
        let label = UILabel()
        label.text = "country"
        label.font = Constants.Fonts.ui14Regular
        label.numberOfLines = 0
        return label
    }()
    
    // футер ячейки с кастомной разделительной линией, включает в себя cellSeparatorView
    private lazy var postFooterView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var postHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = Constants.Fonts.ui16Semi
        return label
    }()
    
    private lazy var postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "dob"
        label.textColor = Constants.Colors.gray03
        label.font = Constants.Fonts.ui14Regular
        return label
    }()
    
    private lazy var cellSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.gray02
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupviews() {
        postFooterView.addSubview(cellSeparatorView)
        contentView.addSubview(mainStack)
    }
    
    private func setupConstraints() {
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        postImage.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        cellSeparatorView.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
