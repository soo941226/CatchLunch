//
//  RestaurantsBookmarkService.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/13.
//

import Foundation

final class RestaurantsBookmarkService: BookmarkService {
    typealias Response = RestaurantInformation

    static let shared = RestaurantsBookmarkService()
    private init() {}

    private let manager = CDModelManager(about: CDRestaurant.self)

    func fetch(
        whereBookmarkedIs flag: Bool,
        completionHandler: @escaping (Result<[RestaurantInformation], Error>) -> Void
    ) {
        let filter = NSPredicate(format: "isBookmarked = \(flag)")

        manager.retrieve(with: filter) { result in
            switch result {
            case .success(let restaurnats):
                let restaurants = restaurnats.map { cdRestaurant in
                    return RestaurantInformation(from: cdRestaurant)
                }
                completionHandler(.success(restaurants))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func checkBookmark(
        about restaurant: RestaurantInformation,
        completionHandler: @escaping (_ isBookmarked: Bool) -> Void
    ) {
        let filter = filter(about: restaurant)

        manager.retrieve(with: filter) { result in
            switch result {
            case .success(let restaurants):
                if let restaurant = restaurants.first {
                    completionHandler(restaurant.isBookmarked)
                } else {
                    completionHandler(false)
                }
            case .failure:
                completionHandler(false)
            }
        }
    }

    func toggleBookmark(
        about restaurant: RestaurantInformation,
        completionHandler: @escaping (Error?) -> Void
    ) {
        let filter = filter(about: restaurant)
        guard let count = manager.count(with: filter) else {
            completionHandler(BookmarkServiceError.canNotCount)
            return
        }

        if count > .zero {
            manager.update(with: filter, setter: { model in
                model.forEach { restaurant in
                    restaurant.isBookmarked.toggle()
                }
            }, completionHandler: completionHandler)
        } else {
            manager.insert { object in
                object.setValue(true, forKey: "isBookmarked")
                object.setValue(restaurant.cityName, forKey: "cityName")
                object.setValue(restaurant.restaurantName, forKey: "restaurantName")
                object.setValue(restaurant.phoneNumber, forKey: "phoneNumber")
                object.setValue(restaurant.locationNameAddress, forKey: "locationNameAddress")
                object.setValue(restaurant.descriptionOfMainFoodNames, forKey: "mainFoodNames")
                object.setValue(restaurant.roadNameAddress, forKey: "roadNameAddress")
                object.setValue(restaurant.refinedZipCode, forKey: "refinedZipCode")
                object.setValue(restaurant.longitude, forKey: "longitude")
                object.setValue(restaurant.latitude, forKey: "latitude")
            } completionHandler: { error in
                completionHandler(error)
            }
        }
    }

    private func filter(about restaurant: RestaurantInformation) -> NSPredicate? {
        guard let restaurantName = restaurant.restaurantName,
              let latitude = restaurant.latitude,
              let longitude = restaurant.longitude else {
                  return nil
              }

        return NSCompoundPredicate(andPredicateWithSubpredicates: [
            .init(format: "restaurantName = %@", restaurantName),
            .init(format: "latitude = %@", latitude.description),
            .init(format: "longitude = %@", longitude.description)
        ])
    }
}

@frozen enum BookmarkServiceError: LocalizedError {
    case canNotCount

    var localizedDescription: String? {
        switch self {
        case .canNotCount:
            return "카운트를 가져오는 중 에러 발생"
        }
    }
}
