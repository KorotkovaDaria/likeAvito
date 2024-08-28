//
//  AdvertisementDetail.swift
//  likeAvito
//
//  Created by Daria on 26.08.2024.
//

import Foundation

// MARK: - AdvertisementDetail
struct AdvertisementDetail: Codable, Hashable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String
    let created_date: String
    let description: String
    let email: String
    let phone_number: String
    let address: String
}
