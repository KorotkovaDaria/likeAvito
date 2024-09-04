//
//  AdCoordinator.swift
//  likeAvito
//
//  Created by Daria on 26.08.2024.
//

import UIKit
protocol AdCoordinatorProtocol: AnyObject {
    
    func goToItemDetails(ad: Advertisement)
    func childDidFinish(childCoordinator: Coordinator)
    
}

final class AdCoordinator: Coordinator, AdCoordinatorProtocol {

    private(set) var parentCoordinator: Coordinator?
    private(set) var childCoordinators: [Coordinator] = []
    private(set) var navigationController =  UINavigationController()
    
    init(parentCoordinator: Coordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = AdvertisementsPresenter(coordinator: self)
        let viewController = AdvertisementsControllerView(presenter: presenter)
        presenter.setView(view: viewController)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func goToItemDetails(ad: Advertisement) {
        //
    }
    
    func childDidFinish(childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}


