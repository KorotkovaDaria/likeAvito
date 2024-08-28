//
//  Advertisements.swift
//  likeAvito
//
//  Created by Daria on 26.08.2024.
//

import Foundation
// MARK: - Advertisements
struct Advertisements: Codable, Hashable{
    let advertisements: [Advertisement]
}

// MARK: - Advertisement
struct Advertisement: Codable, Hashable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String
    let created_date: String
}
