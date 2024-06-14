//
//  SelectImageViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

class SelectImageViewController: UIViewController {
    let rootView = SelectImageRootView()
    var image: Int

    init(image: Int) {
        self.image = image
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
        rootView.selectedimage = image
        rootView.selectImageRootViewDelegate = self
        configureNavi()
    }

    private func configureNavi() {
        navigationItem.title = Constant.LiteralString.Title.NavigationBar.profileSetting.rawValue
    }
}

extension SelectImageViewController: SelectImageRootViewDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        rootView.selectedimage = ProfileImage.imageList[indexPath.item]
    }
}
