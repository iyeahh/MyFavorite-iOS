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

        let image = getImage()
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    private func getImage() -> UIImage? {
        guard let isLikeString = UserDefaultManager.isLike else { return nil }
        let array = isLikeString.makeArray
        let removedArray = array.filter { str in
            str == productId
        }
        if removedArray.count == 0 {
            return Constant.Image.Icon.likeUnselected?.withRenderingMode(.alwaysOriginal)
        } else {
            return Constant.Image.Icon.likeSelected?.withRenderingMode(.alwaysOriginal)
        }
    }
}
