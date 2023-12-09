//
//  SignIn_withGoogle_vm.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

class SignIn_withGoogle_VM: ObservableObject{
    @Published var isLoginSuccess = false
    func signInWithGoogle(){
        //get client id
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController){user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard
                let user = user?.user,
                let idToken = user.idToken else {return}
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential){ res, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                            
                // Since self is not optional, no need for optional chaining here
                DispatchQueue.main.async {
                    self.isLoginSuccess = true // Update the isLoginSuccess directly
                }
            }
        }
        
        
    }
}

