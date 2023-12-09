//
//  SignInPage.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//

import SwiftUI
import FirebaseAuth
import MapKit
import GoogleSignIn
import Firebase
import GoogleSignInSwift

struct SignInPage: View {
    @State var email = ""
    @State var password = ""
    @State private var isAuthenticated = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), // Use the coordinates of your choice
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Adjust the span for how zoomed in you want the map to be initially
        )
    @State private var tappedLocation: CLLocationCoordinate2D?
    @StateObject private var vm = SignIn_withGoogle_VM()

    var body: some View {
        NavigationView {
            VStack {
                Image("Image") // Replace "logo" with the name of your logo image in the asset catalog
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250) // Adjust the size as needed

                Text("Welcome to Share Space!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                TextField("Email:", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                SecureField("Password:", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                
                
                
                Button(action: signUp) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.green)
                        .cornerRadius(5.0)
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 15)
                .cornerRadius(5.0)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .background(
                                    NavigationLink("", destination: MapViewContainer().edgesIgnoringSafeArea(.all), isActive: $isAuthenticated)
                                        .hidden()
                                )
                Text("or")
                    .foregroundColor(.gray)
                Button(action: {
                    vm.signInWithGoogle() // Call the signInWithGoogle function within the closure.
                }) {
                    Text("Sign in with Google")
                        .frame(maxWidth: .infinity)
                        .background(alignment: .leading){
                            Image("Google")
                                .frame(width: 30,alignment: .center)
                        }
                }
                .buttonStyle(.bordered)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .background(
                NavigationLink("", destination: MapViewContainer().edgesIgnoringSafeArea(.all), isActive: $vm.isLoginSuccess)
                    .hidden()
                )
        }
    }

    func signUp() {
        Task {
            do {
                let _ = try await Auth.auth().createUser(withEmail: email, password: password)
                isAuthenticated = true
            } catch {
                alertMessage = error.localizedDescription
                showingAlert = true
            }
        }
    }
    
    
}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
    }
}


