//
//  SelectImageRootView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit
import SnapKit

protocol SelectImageRootViewDelegate: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class SelectImageRootView: BaseView {
    let imageList: [Int]

    var selectedimage = 0 {
        didSet {
            profileImageView.image = UIImage.getProfileImage(selectedimage)
            imageCollectionView.reloadData()
        }
    }

    private let barView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    private let profileImageView = {
        let imageView = ProfileImageView(borderColor: Constant.Color.accent, borderWidth: Constant.LiteralNum.borderWidth5)
        return imageView
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

    private lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 50) / 4
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }

    weak var selectImageRootViewDelegate: SelectImageRootViewDelegate?

    init(imageList: [Int]) {
        self.imageList = imageList
        super.init(frame: .zero)
        configureCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        cameraBackImageView.layer.cornerRadius = cameraBackImageView.frame.width / 2
        cameraCircleImageView.layer.cornerRadius = cameraCircleImageView.frame.width / 2
    }

    override func configureHierarchy() {
        addSubview(barView)
        addSubview(profileImageView)
        addSubview(cameraBackImageView)
        addSubview(cameraCircleImageView)
        addSubview(imageCollectionView)
    }

    override func configureLayout() {
        barView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }

        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(profileImageView.snp.width)
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

        imageCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(cameraBackImageView.snp.bottom).offset(30)
        }
    }

    private func configureCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self

        imageCollectionView.register(SelectImageCollectionViewCell.self, forCellWithReuseIdentifier: SelectImageCollectionViewCell.identifier)
    }
}

extension SelectImageRootView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectImageCollectionViewCell.identifier, for: indexPath) as? SelectImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image = imageList[indexPath.item]
        if image == selectedimage {
            cell.configureIsSelectedBorder()
            cell.configureImage(image)
        } else {
            cell.configureUnSelectedBorder()
            cell.configureImage(image)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectImageRootViewDelegate?.didSelectItemAt(indexPath: indexPath)
    }
}

