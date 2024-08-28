//
//  ItemsCoordinator.swift
//  likeAvito
//
//  Created by Daria on 26.08.2024.
//

import UIKit

class ItemsCoordinator: Coordinator {
    func start() {
        //
    }
    
    private(set) var parentCoordinator: Coordinator?
    private(set) var childCoordinators: [Coordinator] = []
    private(set) var navigationController =  UINavigationController()
    
    init(parentCoordinator: Coordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
}


