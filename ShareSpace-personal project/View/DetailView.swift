//
//  DetailView.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//


import SwiftUI
import PhotosUI

struct DetailView: View {
    var coordinate: CLLocationCoordinate2D?
    @State private var selectedEstablishment: Establishment = .restaurant
    @State private var comment: String = ""
    @State private var isFavorite: Bool = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    @Environment(\.presentationMode) var presentationMode
    var viewModel: PlacesViewModel // Injected from MapViewContainer

    var body: some View {
        VStack {
            Text("Document your discoveries here!")
                .font(.title)
                .padding()

            Picker("Select Establishment Type", selection: $selectedEstablishment) {
                ForEach(Establishment.allCases, id: \.self) { establishment in
                    Text(establishment.rawValue).tag(establishment)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            TextField("Write your review...", text: $comment)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else {
                Button("Add a photo to keep your memories alive") {
                    showingImagePicker = true
                }
                .padding()
            }

            Toggle("Add to Favorite", isOn: $isFavorite)
                .padding()

            Button("Save") {
                let newPlace = LocationModel(
                    coordinate: coordinate ?? CLLocationCoordinate2D(),
                    locationType: selectedEstablishment,
                    comment: comment,
                    isFavorited: isFavorite,
                    image: inputImage
                )
                viewModel.addPlace(newPlace)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()

            Spacer()
        }
        .fullScreenCover(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}

