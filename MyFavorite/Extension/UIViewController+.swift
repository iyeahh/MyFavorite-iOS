//
//  UIViewController+.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/17/24.
//

import UIKit

extension UIViewController {
    func moveNextVC(vc: UIViewController) {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }

    func moveNextVCWithWindow(vc: UIViewController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
