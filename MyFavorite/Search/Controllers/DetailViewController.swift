//
//  DetailViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/16/24.
//

import UIKit

final class DetailViewController: UIViewController {
    var naviTitle: String = ""
    var productId: String = ""
    var url: String = ""
    var isLike: Bool = false {
        didSet {
            let image = getImage()
            setNaviBarButtonImage(image: image)
        }
    }

    private lazy var rootView = SearchDetailRootView(urlString: self.url)

    override func loadView() {
        super.loadView()
        rootView.urlString = url
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
    }
}

extension DetailViewController {
    private func configureNavi() {
        navigationItem.title = naviTitle
    }

    private func getImage() -> UIImage? {
        if isLike {
            return Constant.Image.Icon.likeSelected?.withRenderingMode(.alwaysOriginal)
        } else {
            return Constant.Image.Icon.likeUnselected?.withRenderingMode(.alwaysOriginal)
        }
    }

    private func setNaviBarButtonImage(image: UIImage?) {
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func likeButtonTapped() {
        guard let isLikeString = UserDefaultManager.isLike else { return }
        isLike.toggle()

        if isLike {
            UserDefaultManager.isLike = isLikeString + " " + productId
        } else {
            let array = isLikeString.makeArray
            let removedArray = array.filter { str in
                str != productId
            }
            UserDefaultManager.isLike = removedArray.joined(separator: " ")
        }
    }
}
