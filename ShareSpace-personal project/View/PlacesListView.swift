//
//  PlacesListView.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//

import SwiftUI

struct PlacesListView: View {
    @Binding var places: [LocationModel]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            NavigationView {
                List(places, id: \.id) { place in
                    NavigationLink(destination: PlaceDetailView(place: place)) {
                        VStack(alignment: .leading) {
                            Text(place.locationType.rawValue)
                            Text(place.comment)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("Places I've been")
                .navigationBarItems(leading: Button("Back") {
                                presentationMode.wrappedValue.dismiss()
                            })
            }
        }
}



