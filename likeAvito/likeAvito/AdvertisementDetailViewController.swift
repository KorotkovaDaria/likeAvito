//
//  AdvertisementDetailViewController.swift
//  likeAvito
//
//  Created by Daria on 03.09.2024.
//

import UIKit

class AdvertisementDetailViewController: UIViewController {
    private var advertisement: AdvertisementDetail

    init(advertisement: AdvertisementDetail) {
        self.advertisement = advertisement
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        
    }
}
