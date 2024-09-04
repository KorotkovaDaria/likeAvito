//
//  AdvertisementsControllerView.swift
//  likeAvito
//
//  Created by Daria on 27.08.2024.
//

import UIKit
protocol AdvertisementsViewProtocol: AnyObject {
    func showAdvertisements(_ advertisements: [Advertisement])
    func showError(_ message: String)
    func showDetailAdvertisements(_ ad: AdvertisementDetail)
}

class AdvertisementsControllerView: UIViewController, AdvertisementsViewProtocol {
    
    var presenter: AdvertisementsPresenterProtocol
    var networkManager = NetworkManager.shared
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    private lazy var colletionView = UICollectionView(frame: view.bounds, collectionViewLayout: AdvertisementsControllerView.createTwoColumnFlowLayout(in: view))
    private var advertisementsRes: [Advertisement] = []
    
    init(presenter: AdvertisementsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.getAdvertisements()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroung")
        setupCollectionView()
        setupActivityIndicator()
        setupNavigationBar()
    }
    
    func showAdvertisements(_ advertisements: [Advertisement]) {
        self.advertisementsRes = advertisements
        DispatchQueue.main.async {
            self.colletionView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        //alert
    }
    
    func showDetailAdvertisements(_ ad: AdvertisementDetail) {
        let detailView = AdvertisementDetailViewController(advertisement: ad)
        navigationController?.pushViewController(detailView, animated: true)
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
        let width = view.bounds.width
        let padding: CGFloat = 16
        let minimumItemSpacing: CGFloat = 10
        let numberOfColumns = 2
        
        let totalHorizontalPadding = padding * 2
        let totalSpacing = minimumItemSpacing * CGFloat(numberOfColumns - 1)
        let availableWidth = width - totalHorizontalPadding - totalSpacing
        let itemWidth = availableWidth / CGFloat(numberOfColumns)
        
        let itemHeight: CGFloat = 270
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.minimumLineSpacing = minimumItemSpacing
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        return flowLayout
    }
}

extension AdvertisementsControllerView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisementsRes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier, for: indexPath) as! AdvertisementsCollectionViewCell
        cell.configureCell(advertisement: advertisementsRes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAd = advertisementsRes[indexPath.item]
        presenter.goToItemDetails(selectedAdIdx: selectedAd.id)
    }
}
