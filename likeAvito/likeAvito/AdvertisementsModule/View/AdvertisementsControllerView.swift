//
//  AdvertisementsControllerView.swift
//  likeAvito
//
//  Created by Daria on 27.08.2024.
//

import UIKit

class AdvertisementsControllerView: UIViewController {

    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    private lazy var colletionView = UICollectionView(frame: view.bounds, collectionViewLayout: AdvertisementsControllerView.createTwoColumnFlowLayout(in: view))
    private var advertisementsRes: [Advertisement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupActivityIndicator()
        setupNavigationBar()
        fetchData()
    }

    private func fetchData() {
        NetworkManager.shared.getAdvertisements { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let advertisements):
                self.advertisementsRes = advertisements.advertisements
                print(self.advertisementsRes)
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setupCollectionView() {
        view.addSubview(colletionView)
        colletionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colletionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            colletionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            colletionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            colletionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        colletionView.register(AdvertisementsCollectionViewCell.self, forCellWithReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.alwaysBounceVertical = true
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.title = "searchControllerTitle"
        navigationItem.backButtonTitle = "backButtonTitle"
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 8
        let minimumItemSpacing: CGFloat = 4
        let numberOfColumns             = 2
        
        let availableWidth = width - (padding * CGFloat(numberOfColumns + 1)) - (minimumItemSpacing * CGFloat(numberOfColumns - 1))
        let itemWidth      = availableWidth / CGFloat(numberOfColumns)
        
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.sectionInset            = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.minimumLineSpacing      = minimumItemSpacing
        flowLayout.itemSize                = CGSize(width: itemWidth, height: itemWidth + 30)
        
        return flowLayout
    }
}

extension AdvertisementsControllerView: UICollectionViewDelegate {
    
    
}

extension AdvertisementsControllerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisementsRes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier, for: indexPath) as! AdvertisementsCollectionViewCell
        cell.configureCell(advertisement: advertisementsRes[indexPath.item])
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 3
        return cell
    }
}
