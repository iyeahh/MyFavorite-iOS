//
//  SearchDetailRootView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/16/24.
//

import UIKit
import WebKit
import SnapKit

final class SearchDetailRootView: BaseView {
    var urlString: String

    private let webView = WKWebView()

    init(urlString: String) {
        self.urlString = urlString
        super.init(frame: .zero)
        webViewLoad()
    }

    override func configureHierarchy() {
        addSubview(webView)
    }

    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    private func webViewLoad() {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
