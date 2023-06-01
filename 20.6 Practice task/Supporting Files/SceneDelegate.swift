//
//  SceneDelegate.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        window.windowScene = windowScene
        window.makeKeyAndVisible()
        
        let naavi = UINavigationController(rootViewController: ListViewController())
        naavi.navigationBar.prefersLargeTitles = true
        naavi.view.backgroundColor = .systemBackground
        
        window.rootViewController = naavi
    }
}

