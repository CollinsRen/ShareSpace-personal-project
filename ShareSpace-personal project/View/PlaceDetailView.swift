//
//  PlaceDetailView.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//

import SwiftUI

struct PlaceDetailView: View {
    var place: LocationModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let image = place.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }

                Text("Type: \(place.locationType.rawValue)")
                Text("Comment: \(place.comment)")
                if place.isFavorited {
                    Text("This place is a favorite!")
                }
            }
            .padding()
        }
        .navigationTitle("You've Been Here...")
    }
}


