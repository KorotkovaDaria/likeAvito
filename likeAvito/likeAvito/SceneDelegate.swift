//
//  SceneDelegate.swift
//  likeAvito
//
//  Created by Daria on 26.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordiator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
//        appCoordinator = AppCoordiator(window: window)
//        appCoordinator?.start()
        window.rootViewController = AdvertisementsControllerView()
        window.makeKeyAndVisible()
    }
}

