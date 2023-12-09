//
//  PlacesViewModel.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//

import SwiftUI

class PlacesViewModel: ObservableObject {
    @Published var places: [LocationModel] = []
    
    func addPlace(_ place: LocationModel) {
        places.append(place)
    }
}


