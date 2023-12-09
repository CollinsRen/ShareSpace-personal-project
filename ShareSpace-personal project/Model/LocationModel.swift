//
//  LocationModel.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//

import Foundation
import CoreLocation
import SwiftUI

struct LocationModel: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    var locationType: Establishment
    var comment: String
    var isFavorited: Bool
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D,
         locationType: Establishment,
         comment: String = "",
         isFavorited: Bool = false,
         image: UIImage? = nil) {
        self.id = UUID()
        self.coordinate = coordinate
        self.locationType = locationType
        self.comment = comment
        self.isFavorited = isFavorited
        self.image = image
    }
}

enum Establishment: String, CaseIterable {
    case restaurant = "Restaurant"
    case park = "Park"
    case museum = "Museum"
    case cinema = "Cinema"
    case bar = "Bar"
    case coffeeShop = "Coffee Shop"
    case hotel = "Hotel"
    case shoppingMall = "Shopping Mall"
}


