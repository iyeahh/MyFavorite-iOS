//
//  OnBoardingView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit
import SnapKit

protocol OnBoardingViewDelegate: AnyObject {
    func startButtonTapped()
}

final class OnBoardingView: UIView {
    private let serviceTitleLabel = {
        let label = UILabel()
        label.font = Constant.Font.title
        label.textAlignment = .center
        label.text = Constant.LiteralString.Title.service
        label.textColor = Constant.Color.accent
        return label
    }()

    private let mainImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constant.Image.Picture.main
        return imageView
    }()

    private let startButton = {
        let button = AccentColorButton(title: Constant.LiteralString.Title.Button.start)
        button.addTarget(nil, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    weak var onBoardingViewDelegate: OnBoardingViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func startButtonTapped() {
        onBoardingViewDelegate?.startButtonTapped()
    }
}

extension OnBoardingView {
    private func configureUI() {
        self.backgroundColor = Constant.Color.secondary
    }

    private func configureHierarchy() {
        addSubview(serviceTitleLabel)
        addSubview(mainImageView)
        addSubview(startButton)
    }

    private func configureLayout() {
        serviceTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.horizontalEdges.equalToSuperview().inset(30)
        }

        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }

        mainImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
            make.width.equalTo(mainImageView.snp.height)
        }
    }
}
