//
//  DetailViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/16/24.
//

import UIKit

final class DetailViewController: UIViewController {
    var detailResult: DetailResult
    var isLike: Bool {
        didSet {
            let image = detailResult.getImage(isLike: isLike)
            setNaviBarButtonImage(image: image)
        }
    }

    private lazy var rootView = SearchDetailRootView(urlString: self.detailResult.url)

    init(detailResult: DetailResult, isLike: Bool) {
        self.detailResult = detailResult
        self.isLike = isLike
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
    }
}

extension DetailViewController {
    private func configureNavi() {
        navigationItem.title = detailResult.naviTitle
    }

    private func setNaviBarButtonImage(image: UIImage?) {
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func likeButtonTapped() {
        isLike.toggle()
        UserDefaultManager.likeButtonTapped(isLike: isLike, productId: detailResult.productId)
    }
}
