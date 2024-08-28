//
//  AdvertisementsCollectionViewCell.swift
//  likeAvito
//
//  Created by Daria on 27.08.2024.
//

import UIKit

class AdvertisementsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "AdvertisementsCollectionViewCell"
    
    private lazy var contentNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //contentView.backgroundColor = .gray
        
        contentView.addSubview(contentNameLabel)
        
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    private func setupConstraints() {
        contentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            contentNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentNameLabel.text = nil
        
    }
    
    func configureCell(advertisement: Advertisement) {
        contentNameLabel.text = advertisement.title
    }
}
