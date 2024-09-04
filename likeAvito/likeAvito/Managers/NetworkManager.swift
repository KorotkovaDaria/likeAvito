//
//  NetworkManager.swift
//  likeAvito
//
//  Created by Daria on 26.08.2024.
//

import UIKit

// MARK: - Enum
enum urlString {
    static let baseAdvertisementsURL = "https://www.avito.st/s/interns-ios/main-page.json"
    static let baseDetailURL = "https://www.avito.st/s/interns-ios/details/"
    static let endpointForDetailURL = ".json"
}

// MARK: - Protocol

protocol NetworkManagerProtocol {
    typealias AdvertisementsResult = (Result <Advertisements, AdvertisementsError>) -> Void
    typealias AdvertisementDetailResult = (Result <AdvertisementDetail, AdvertisementsError>) -> Void
    
    func getAdvertisements(completed: @escaping AdvertisementsResult)
    func getAdvertisementDetail(item id: String?, completed: @escaping AdvertisementDetailResult)
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)
}

// MARK: - Network class
final class NetworkManager: NetworkManagerProtocol {
    private var session = URLSession.shared
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    func getAdvertisements(completed: @escaping AdvertisementsResult) {
        let urlString = urlString.baseAdvertisementsURL
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let advertisements = try decoder.decode(Advertisements.self, from: data)
                completed(.success(advertisements))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getAdvertisementDetail(item id: String?, completed: @escaping AdvertisementDetailResult) {
        guard let idItem = id else { return }
        let endpoint = "\(urlString.baseDetailURL)\(idItem)\(urlString.endpointForDetailURL)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let detailItem = try decoder.decode(AdvertisementDetail.self, from: data)
                completed(.success(detailItem))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
    
}
