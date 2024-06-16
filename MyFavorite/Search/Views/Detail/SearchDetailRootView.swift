//
//  SearchDetailRootView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/16/24.
//

import UIKit
import WebKit
import SnapKit

final class SearchDetailRootView: UIView {
    var urlString: String

    private let webView = WKWebView()

    init(urlString: String) {
        self.urlString = urlString
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
        configureUI()
        webViewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchDetailRootView {
    private func configureHierarchy() {
        addSubview(webView)
    }

    private func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    private func configureUI() {
        backgroundColor = Constant.Color.secondary
    }

    private func webViewLoad() {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
