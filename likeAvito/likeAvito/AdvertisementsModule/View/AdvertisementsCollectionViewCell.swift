//
//  AdvertisementsCollectionViewCell.swift
//  likeAvito
//
//  Created by Daria on 27.08.2024.
//

import UIKit

class AdvertisementsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "AdvertisementsCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let imageView = UIImageView()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 8, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(createdDateLabel)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        createdDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 175),
            imageView.heightAnchor.constraint(equalToConstant: 175),
                    
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            createdDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configureCell(advertisement: Advertisement) {
        titleLabel.text = advertisement.title
        priceLabel.text = advertisement.price
        locationLabel.text = advertisement.location
        createdDateLabel.text = advertisement.created_date
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        
        NetworkManager.shared.downloadImage(from: advertisement.image_url) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
}
