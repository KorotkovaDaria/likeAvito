//
//  AppCoordiator.swift
//  likeAvito
//
//  Created by Daria on 26.08.2024.
//

import UIKit

final class AppCoordiator: Coordinator {
    private(set) var parentCoordinator: Coordinator?
    private(set) var childCoordinators: [Coordinator] = []
    private(set) var navigationController =  UINavigationController()
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
        let itemsCoordinator = AdCoordinator(parentCoordinator: self, navigationController: navigationController)
        childCoordinators.append(itemsCoordinator)
        itemsCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
