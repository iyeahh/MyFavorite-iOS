//
//  SetNicknameView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit
import SnapKit

protocol SetNicknameViewDelegate: AnyObject {
    func textFieldDidChange(_ sender: UITextField)
    func setImageButtonTapped()
    func completeButtonTapped()
}

final class SetNicknameView: BaseView {
    var state: State

    var nickname: String? {
        didSet {
            nicknameTextField.text = nickname
        }
    }

    var profileImage = 0 {
        didSet {
            profileImageView.image = UIImage.getProfileImage(profileImage)
        }
    }

    var descriptionContent = "" {
        didSet {
            descriptionLabel.text = descriptionContent
        }
    }

    private let naviBarView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    private let profileImageView = {
        let imageView = ProfileImageView(borderColor: Constant.Color.accent, borderWidth: Constant.LiteralNum.borderWidth5)
        return imageView
    }()

    private let setImageButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.addTarget(nil, action: #selector(setImageButtonTapped), for: .touchUpInside)
        return button
    }()

    private let cameraBackImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Constant.Color.accent
        return imageView
    }()

    private let cameraCircleImageView = {
        let imageView = UIImageView()
        imageView.image = Constant.Image.Icon.camera
        imageView.tintColor = Constant.Color.secondary
        imageView.backgroundColor = Constant.Color.accent
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let nicknameTextField = {
        let textField = UITextField()
        textField.placeholder = Constant.LiteralString.Nickname.placeholer
        textField.borderStyle = .none
        textField.font = Constant.Font.system14
        return textField
    }()

    private let barView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    private let descriptionLabel = {
        let label = UILabel()
        label.textColor = Constant.Color.accent
        label.text = Constant.LiteralString.Nickname.incorrectNumber
        label.font = Constant.Font.system13
        return label
    }()

    private let completeButton = {
        let button = AccentColorButton(title: Constant.LiteralString.Title.Button.complete)
        button.addTarget(nil, action: #selector(completeButtonTapped), for: .touchUpInside)
        return button
    }()

    weak var setNicknameViewDelegate: SetNicknameViewDelegate?

    init(state: State) {
        self.state = state
        super.init(frame: .zero)
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        if state == .edit {
            completeButton.isHidden = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        cameraBackImageView.layer.cornerRadius = cameraBackImageView.frame.width / 2
        cameraCircleImageView.layer.cornerRadius = cameraCircleImageView.frame.width / 2
    }
    
    override func configureHierarchy() {
        addSubview(naviBarView)
        addSubview(profileImageView)
        addSubview(setImageButton)
        addSubview(cameraBackImageView)
        addSubview(cameraCircleImageView)
        addSubview(nicknameTextField)
        addSubview(barView)
        addSubview(descriptionLabel)
        addSubview(completeButton)
    }

    override func configureLayout() {
        naviBarView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(profileImageView.snp.width)
        }

        setImageButton.snp.makeConstraints { make in
            make.edges.equalTo(profileImageView)
        }

        cameraBackImageView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
            make.width.equalTo(profileImageView).multipliedBy(0.25)
            make.height.equalTo(cameraBackImageView.snp.width)
        }

        cameraCircleImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(cameraBackImageView)
            make.width.equalTo(cameraBackImageView).multipliedBy(0.7)
            make.height.equalTo(cameraCircleImageView.snp.width)
        }

        nicknameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
        }

        barView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.height.equalTo(1)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(barView.snp.bottom).offset(10)
        }

        completeButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
    }
}

extension SetNicknameView {
    @objc private func setImageButtonTapped() {
        setNicknameViewDelegate?.setImageButtonTapped()
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {
        setNicknameViewDelegate?.textFieldDidChange(sender)
    }

    @objc private func completeButtonTapped() {
        setNicknameViewDelegate?.completeButtonTapped()
    }
}
