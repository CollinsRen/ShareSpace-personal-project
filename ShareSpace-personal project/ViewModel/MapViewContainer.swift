//
//  MapViewContainer.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//


import SwiftUI
import MapKit

struct MapViewContainer: View {
   
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var isShowingDetailView = false
    @State private var showingPlacesList = false // State to control the display of the places list
    @StateObject private var viewModel = PlacesViewModel()
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing) { // Align content to the bottom right
                MapView(selectedCoordinate: $selectedCoordinate, isShowingDetailView: $isShowingDetailView)
                    .edgesIgnoringSafeArea(.all)

                if isShowingDetailView {
                    NavigationLink(
                        destination: DetailView(coordinate: selectedCoordinate, viewModel: viewModel), // Pass viewModel here
                        isActive: $isShowingDetailView
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }

                // Button to show the list of places
                Button(action: {
                    showingPlacesList.toggle()
                }) {
                    Image(systemName: "list.bullet")
                        .padding()
                        .background(Color.primary)
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                }
                .padding(20) // Adjust padding here to position the button
                .fullScreenCover(isPresented: $showingPlacesList) {
                    PlacesListView(places: $viewModel.places) // Show the list of places
                }
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle()) // ensures a consistent navigation experience on all devices.
        }
    }
}

#Preview {
    MapViewContainer()
}
