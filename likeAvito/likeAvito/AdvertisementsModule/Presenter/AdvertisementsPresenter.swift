//
//  AdvertisementsPresenter.swift
//  likeAvito
//
//  Created by Daria on 28.08.2024.
//

import UIKit

protocol AdvertisementsPresenterProtocol {
    func getAdvertisements()
    func goToItemDetails(selectedAdIdx: String?)
}

final class AdvertisementsPresenter {
    weak private var view: AdvertisementsViewProtocol?
    private let networkManager: NetworkManagerProtocol
    weak private var coordinator: AdCoordinatorProtocol?
    
    init(coordinator: AdCoordinatorProtocol) {
        self.coordinator = coordinator
        self.networkManager = NetworkManager()
    }
    
    func setView(view: AdvertisementsViewProtocol) {
        self.view = view
    }
}


extension AdvertisementsPresenter: AdvertisementsPresenterProtocol {
    func getAdvertisements() {
        networkManager.getAdvertisements { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let advertisements):
                DispatchQueue.main.async {
                    self.view?.showAdvertisements(advertisements.advertisements)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func goToItemDetails(selectedAdIdx: String?) {
        networkManager.getAdvertisementDetail(item: selectedAdIdx) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let ad):
                DispatchQueue.main.async {
                    self.view?.showDetailAdvertisements(ad)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
}
