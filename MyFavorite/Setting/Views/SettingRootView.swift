//
//  SettingRootView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/17/24.
//

import UIKit
import SnapKit

protocol SettingRootViewDelegate: AnyObject {
    func selectCell(index: Int)
    func editButtonTapped()
}

final class SettingRootView: UIView {
    var userInfo: UserInfo? {
        didSet {
            configureUserInfo()
            settingTableView.reloadData()
        }
    }

    private let settingList = [
        Constant.LiteralString.Setting.shoppingList.rawValue,
        Constant.LiteralString.Setting.question.rawValue,
        Constant.LiteralString.Setting.inquiry.rawValue,
        Constant.LiteralString.Setting.alarm.rawValue,
        Constant.LiteralString.Setting.cancelMembership.rawValue
        ]

    private let topBarView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    private let profileImageView = {
        let imageView = ProfileImageView(borderColor: Constant.Color.accent, borderWidth: Constant.Charactor.isSelected.borderSetting.borderWidth)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        return imageView
    }()

    private let nickNameLabel = {
        let label = UILabel()
        label.font = Constant.Font.nickname
        label.textColor = Constant.Color.primary
        return label
    }()

    private let joinDateLabel = {
        let label = UILabel()
        label.font = Constant.Font.system14
        label.textColor = Constant.Color.secondaryGray
        return label
    }()

    private let nextImageView = {
        let imageView = UIImageView()
        imageView.image = Constant.Image.Icon.arrow
        imageView.tintColor = Constant.Color.secondaryGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let editButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.addTarget(nil, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    private let tableViewBar = {
        let view = BarView(color: Constant.Color.primary)
        return view
    }()

    private let settingTableView = {
        let tableView = UITableView()
        return tableView
    }()

    private let bottomBarView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    weak var settingRootViewDelegate: SettingRootViewDelegate?

    init(userInfo: UserInfo?) {
        self.userInfo = userInfo
        super.init(frame: .zero)
        configureUI()
        configureHierarchy()
        configureLayout()
        configureTableView()
        configureUserInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func editButtonTapped() {
        settingRootViewDelegate?.editButtonTapped()
    }
}

extension SettingRootView {
    private func configureUI() {
        backgroundColor = Constant.Color.secondary
    }

    private func configureHierarchy() {
        addSubview(topBarView)
        addSubview(profileImageView)
        addSubview(nickNameLabel)
        addSubview(joinDateLabel)
        addSubview(nextImageView)
        addSubview(editButton)
        addSubview(tableViewBar)
        addSubview(settingTableView)
        addSubview(bottomBarView)
    }

    private func configureLayout() {
        topBarView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }

        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.width.height.equalTo(80)
        }

        nickNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(30)
            make.bottom.equalTo(profileImageView.snp.centerY)
        }

        joinDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(30)
        }

        nextImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.width.height.equalTo(15)
        }

        settingTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(1)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
        }

        tableViewBar.snp.makeConstraints { make in
            make.bottom.equalTo(settingTableView.snp.top)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(1)
        }

        editButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(settingTableView.snp.top)
        }

        bottomBarView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    private func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        settingTableView.separatorColor = Constant.Color.primary
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }

    private func configureUserInfo() {
        guard let userInfo = userInfo else { return }
        profileImageView.image = UIImage.getProfileImage(userInfo.image)
        nickNameLabel.text = userInfo.nickname
        joinDateLabel.text = userInfo.joinDate + " 가입"
    }
}

extension SettingRootView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        let data = settingList[indexPath.row]
        cell.setData(index: indexPath.row, count: UserDefaultManager.isLikeListCount, text: data)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingRootViewDelegate?.selectCell(index: indexPath.row)
    }
}
